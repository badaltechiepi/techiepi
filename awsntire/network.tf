#vpc creation
resource "aws_vpc" "myvpc"{
    cidr_block = var.cidr_block
    tags = {
    Name = "ntier primary"
  }
}
#subnet creation
resource "aws_subnet" "mysubnet"{
    vpc_id     = aws_vpc.myvpc.id
    count      = length(var.subnets)
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
     tags = {
    Name = var.subnets[count.index]
  }
}
#let's create the internet gateway

resource "aws_internet_gateway" "ntire" {
  vpc_id     = aws_vpc.myvpc.id
  tags = {
    Name = "ntiregw"
  }

  depends_on = [
     aws_subnet.mysubnet 
  ]
}
#let's create the route table

resource "aws_route_table" "publicroute_table" {
  vpc_id = aws_vpc.myvpc.id
  count = length(var.route_table_names)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ntire.id
  }
  tags = {
    Name = var.route_table_names[count.index]
  }
}


#let's create the association between the public and private table

locals {
  public_subnet = lookup(var.accosiation, "public")
  private_subnet = lookup(var.accosiation, "private")
}

resource "aws_route_table_association" "public-associations" {
  subnet_id      = aws_subnet.mysubnet[local.public_subnet[count.index]].id
  route_table_id = aws_route_table.publicroute_table[0].id
  count = length(var.public_subnet)
}
resource "aws_route_table_association" "private-associations" {
  subnet_id      = aws_subnet.mysubnet[local.private_subnet[count.index]].id
  route_table_id = aws_route_table.publicroute_table[0].id
  count = length(var.private_subnet)
}

#let's create the DB
#we will create the DB in next session
