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

#let's create the DB


