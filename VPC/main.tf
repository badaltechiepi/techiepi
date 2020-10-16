#creatig the VPC in aws
resource "aws_vpc" "myvpc" {
  cidr_block        = "192.168.0.0/16" 
  tags = {
      Name      = "fistvpc"
  }
}

#creating the subnets for web

resource "aws_subnet" "web"{
  cidr_block    = "192.168.0.0/24"
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "web"
  }
}
#creating the subnets for app

resource "aws_subnet" "app"{
  cidr_block    = "192.168.1.0/24"
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "app"
  }
}

#creating the subnets for db

resource "aws_subnet" "db"{
  cidr_block    = "192.168.2.0/24"
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "db"
  }
}

#creating the subnets for mgmt

resource "aws_subnet" "mgmt"{
  cidr_block    = "192.168.3.0/24"
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = "mgmt"
  }
}