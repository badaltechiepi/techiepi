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
#The below is created the for the InternetGateWay
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sunbird_VPC.id

  tags = {
    Name = "sunbird_igw"
  }
  #creating this internet getway only after the sunbet got created. don't go parallay. 
  #Depends on defind the dependency in the template creation.
  depends_on  = [
        aws_subnet.sunbird_subnets
    ]
}
#The below is created for the routung table
#creating the routing table for the public
resource "aws_route_table" "sunbird_route_table" {
  vpc_id = aws_vpc.sunbird_VPC.id
  count = length(var.sunbird_route_table_names)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.sunbird_route_table_names[count.index]
  }
}
#associated public and private route table accrodingly. to achive this we will using map variable along with lookup function.
# to store the value we are using the local(defind variable to store the value locally inside the template) 
#Public(web,mgmt,web2)
#count only take the index and the public subnet store the values like 0,3,4
#When we do the itration so it will itrate the values like 0,3,4 

locals{

  public_subnet = lookup(var.sunbird_route_table_association,"public")
  private_subnet = lookup(var.sunbird_route_table_association,"private")
  db_subents   = lookup(var.sunbird_RDS,"dbsubnet")
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.sunbird_subnets[local.public_subnet[count.index]].id
  route_table_id = aws_route_table.sunbird_route_table[0].id
  count = length(local.public_subnet)
}
#private(app, app2, db, db2)
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.sunbird_subnets[local.private_subnet[count.index]].id
  route_table_id = aws_route_table.sunbird_route_table[1].id
  count = length(local.private_subnet)
}
#Creating the RDS and associated the db subnets with the group table. 

resource "aws_db_subnet_group" "ntier-db-group" {
  name       = "ntire"
  count = length(local.db_subents)
  subnet_ids = [aws_subnet.sunbird_subnets[local.db_subents[count.index]].id]
  tags = {
    Name = "My DB subnet group"
  }
  depends_on  = [
        aws_subnet.sunbird_subnets,
        aws_route_table_association.public_association,
        aws_route_table_association.private_association,
    ]
}
