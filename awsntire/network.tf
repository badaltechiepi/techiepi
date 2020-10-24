#creating  VPC 
resource "aws_vpc" "sunbird_VPC" {

  cidr_block      = var.sunbird_cidr_block
  tags = {
    
    Name = "sunbird_VPC"
  }

}
#The below are the subent created for the ntire architecture
# creating the subnets(web,app,db,mgmt)
resource "aws_subnet" "sunbird_subnets" {

  vpc_id     = aws_vpc.sunbird_VPC.id
  cidr_block = cidrsubnet(var.sunbird_cidr_block,8,count.index)
  count = length(var.subnird_subnets)
  tags = {
    Name = var.subnird_subnets[count.index]
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
  subnet_id      = aws_subnet.sunbird_subnets_web.id
  route_table_id = aws_route_table.sunbird_route_pubic.id
}
resource "aws_route_table_association" "public-association1" {
  subnet_id      = aws_subnet.sunbird_subnets_mgmt.id
  route_table_id = aws_route_table.sunbird_route_pubic.id
}
#private
resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.sunbird_subnets_app.id
  route_table_id = aws_route_table.sunbird_route_private.id
}
resource "aws_route_table_association" "private-association1" {
  subnet_id      = aws_subnet.sunbird_subnets_db.id
  route_table_id = aws_route_table.sunbird_route_private.id
}
