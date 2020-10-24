#creating  VPC 
resource "aws_vpc" "sunbird_VPC" {

  cidr_block      = "10.0.0.0/16"
  tags = {
    
    Name = "sunbird_VPC"
  }

}
#The below are the subent created for the ntire architecture
# creating the subnet for web
resource "aws_subnet" "sunbird_subnets_web" {

  vpc_id     = aws_vpc.sunbird_VPC.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "web"
  }

}
#creating the subnet for the app
resource "aws_subnet" "sunbird_subnets_app" {

  vpc_id     = aws_vpc.sunbird_VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "app"
  }

}
# creating the subnet for the mgmt
resource "aws_subnet" "sunbird_subnets_mgmt" {

  vpc_id     = aws_vpc.sunbird_VPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "mgmt"
  }

}
#creating the subnet for the db
resource "aws_subnet" "sunbird_subnets_db" {

  vpc_id     = aws_vpc.sunbird_VPC.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "db"
  }

}
#The below is created the for the IG
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sunbird_VPC.id

  tags = {
    Name = "sunbird_igw"
  }
  depends_on  = [
        aws_subnet.sunbird_subnets_web,
        aws_subnet.sunbird_subnets_app,
        aws_subnet.sunbird_subnets_mgmt,
        aws_subnet.sunbird_subnets_db
    ]
}
#The below is created for the routung table
#creating the routing table for the public
resource "aws_route_table" "sunbird_route_pubic" {
  vpc_id = aws_vpc.sunbird_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public"
  }
}
# creating the route table for the private
resource "aws_route_table" "sunbird_route_private" {
  vpc_id = aws_vpc.sunbird_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "private"
  }
}

#associated public and private route table accrodingly.
#Public
resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.sunbird_subnets_web
  route_table_id = aws_route_table.sunbird_route_pubic.id
}
resource "aws_route_table_association" "public-association1" {
  subnet_id      = aws_subnet.sunbird_subnets_mgmt
  route_table_id = aws_route_table.sunbird_route_pubic.id
}
#private
resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.sunbird_subnets_app
  route_table_id = aws_route_table.sunbird_route_private.id
}
resource "aws_route_table_association" "private-association1" {
  subnet_id      = aws_subnet.sunbird_subnets_db
  route_table_id = aws_route_table.sunbird_route_private.id
}
