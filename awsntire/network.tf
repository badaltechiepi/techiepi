#creating  VPC 
resource "aws_vpc" "sunbird_VPC" {

  cidr_block      = "10.0.0.0/16"
  tags = {
    
    Name = "sunbird_VPC"
  }

}

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

