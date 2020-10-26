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
  name        = var.db_subnet_name
  description = "Allow mysql inbound traffic"
  vpc_id      = aws_vpc.sunbird_VPC.id

  ingress {
      description = "creating the inbound rule for the db"
      cidr_blocks = local.cidr_block
      from_port =  local.ingress_from_db_port
      protocol = local.proto
      to_port = local.ingress_to_db_port
  }
  egress {
      description = "creating the outbound rule for the db"
      cidr_blocks = local.cidr_block
      from_port =  local.egress_from_port
      protocol = local.proto
      to_port = local.egress_to_port
  }  
  depends_on    = [
      aws_db_subnet_group.sunbird-ntier-db-group
  ]
}
resource "aws_db_instance" "sunbird_primary_db"{
    allocated_storage = local.allocated_storage
    allow_major_version_upgrade = false
    auto_minor_version_upgrade = true
    db_subnet_group_name = local.db_subnet_group_name
    engine = local.engine
    engine_version = var.engine_version
    identifier = var.identifier
    instance_class = var.instance_class
    max_allocated_storage = 0
    multi_az = var.multi_az
    name = var.Name
    password = local.password
    username = local.username
    publicly_accessible = false
    vpc_security_group_ids = [aws_security_group.rds-sg.id]
    skip_final_snapshot = true
    
    depends_on  =[
        aws_security_group.rds-sg,
        aws_db_subnet_group.sunbird-ntier-db-group

    ]

    }  