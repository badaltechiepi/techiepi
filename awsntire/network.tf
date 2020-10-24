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
#Public gate way for the web and mgmt
resource "aws_internet_gateway" "sunbird_IG_public" {
  vpc_id = aws_vpc.sunbird_VPC.id

  tags = {
    Name = "public"
  }
}
#Private gate way for the db and app
resource "aws_internet_gateway" "sunbird_IG_private" {
  vpc_id = aws_vpc.sunbird_VPC.id

  tags = {
    Name = "private"
  }
}



