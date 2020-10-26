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