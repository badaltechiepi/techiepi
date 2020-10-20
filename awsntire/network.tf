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

resource "aws_route_table_association" "public-associations" {
  subnet_id      = aws_subnet.mysubnet[local.public_subnet[count.index]].id
  route_table_id = aws_route_table.publicroute_table[0].id
  count = length(local.public_subnet)
}
resource "aws_route_table_association" "private-associations" {
  subnet_id      = aws_subnet.mysubnet[local.private_subnet[count.index]].id
  route_table_id = aws_route_table.publicroute_table[1].id
  count = length(local.private_subnet)
}

#let's create the DB
## Fetch subnet ids for db subnets
data "aws_subnet_ids" "dbsubnets" {
    vpc_id          = aws_vpc.myvpc.id
    filter {
        name   = "tag:Name"
        values = local.dbsubnets 
    }
}

resource "aws_db_subnet_group" "ntier-db-group" {
    name            = "ntier"
    subnet_ids      = data.aws_subnet_ids.dbsubnets.ids
    tags            = {
        Name        =  "ntier-db-subnet-group"
    }

    depends_on  = [
        aws_vpc.myvpc,
        aws_subnet.mysubnet,
        aws_route_table_association.public-associations,
        aws_route_table_association.private-associations,
    ]
}
