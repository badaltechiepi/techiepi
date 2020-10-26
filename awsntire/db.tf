/* #Creating the RDS and associated the db subnets with the group table. 

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
} */

#fetch the subnetID from  the subents
data "aws_subnet_ids" "dbsubnets" {
  vpc_id = aws_vpc.sunbird_VPC.id
  filter {
    name   = "tag:Name"
    values = local.dbsubents # insert values here
  }
}
#creating the db subenet groups
resource "aws_db_subnet_group" "sunbird-ntier-db-group" {
  name       = "sunbird_ntire"
  subnet_ids = data.aws_subnet_ids.dbsubnets.ids

  tags = {
    Name = "sunbird-ntier-db-subnet-group"
  }
  depends_on  = [
        aws_subnet.sunbird_subnets,
        aws_route_table_association.public_association,
        aws_route_table_association.private_association,
    ]
}

#Creating the network security group for the inbound and outbound network for the DB

resource "aws_security_group" "rds-sg" {
  name        = "allow_mysql"
  description = "Allow mysql inbound traffic"
  vpc_id      = aws_vpc.sunbird_VPC.id

  ingress {
      description = "creating the inbound rule for the db"
      cidr_blocks = ["0.0.0.0/0"]
      from_port =  3306
      protocol = "tcp"
      to_port = 3306
  }
  egress {
      description = "creating the outbound rule for the db"
      cidr_blocks = ["0.0.0.0/0"]
      from_port =  0
      protocol = "tcp"
      to_port = 65535
  }  
  depends_on    = [
      aws_db_subnet_group.sunbird-ntier-db-group
  ]
}
resource "aws_db_instance" "sunbird_primary_db"{
    allocated_storage = 20
    allow_major_version_upgrade = false
    auto_minor_version_upgrade = true
    db_subnet_group_name = "sunbird_ntire"
    engine = "mysql"
    engine_version = "8.0.20"
    identifier = "lt-ntier-primary"
    instance_class = "db.t2.micro"
    max_allocated_storage = 0
    multi_az = false
    name = "sunbird_lthrms"
    password = "rootroot"
    username = "sunbird"
    publicly_accessible = false
    vpc_security_group_ids = [aws_security_group.rds-sg.id]
    
    depends_on  =[
        aws_security_group.rds-sg,
        aws_db_subnet_group.sunbird-ntier-db-group

    ]

    }  