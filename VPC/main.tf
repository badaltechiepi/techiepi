#creatig the VPC in aws
resource "aws_vpc" "myvpc" {
  cidr_block        = var.vpc
  tags = {
      Name      = "fistvpc"
  }
}

#creating the subnets for web

resource "aws_subnet" "web"{
  cidr_block    = cidrsubnet("10.0.0.0/16", 8, 0)
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "web"
  }
}
#creating the subnets for app

resource "aws_subnet" "app"{
  cidr_block    = cidrsubnet("10.0.0.0/16", 8, 1)
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "app"
  }
}

#creating the subnets for db

resource "aws_subnet" "db"{
  cidr_block    = cidrsubnet("10.0.0.0/16", 8, 2)
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "db"
  }
}

#creating the subnets for mgmt

resource "aws_subnet" "mgmt"{
  cidr_block    = cidrsubnet("10.0.0.0/16", 8, 3)
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "mgmt"
  }
}