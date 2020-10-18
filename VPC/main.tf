#creatig the VPC in aws
resource "aws_vpc" "myvpc" {
  cidr_block        = var.cidr_block
  tags = {
      Name      = var.tagname[0]
  }
}

#creating the subnets for web

resource "aws_subnet" "web"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 0)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sa", var.region)
  tags = {
  Name          = var.tagname[1]
  }
}
#creating the subnets for app


resource "aws_subnet" "app"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 1)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sb", var.region)
  tags = {
  Name          = var.tagname[2]
  }
}

#creating the subnets for db

resource "aws_subnet" "db"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 2)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sc", var.region)
  
  tags = {
  Name          = var.tagname[3]
  }
}

#creating the subnets for mgmt

resource "aws_subnet" "mgmt"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 3)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sa", var.region)
  tags = {
  Name          = var.tagname[4]
  }
}