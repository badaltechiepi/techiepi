#associated public and private route table accrodingly. to achive this we will using map variable along with lookup function.
# to store the value we are using the local(defind variable to store the value locally inside the template) 
#Public(web,mgmt,web2)
#count only take the index and the public subnet store the values like 0,3,4
#When we do the itration so it will itrate the values like 0,3,4 

locals{

  public_subnet = lookup(var.sunbird_route_table_association,"public")
  private_subnet = lookup(var.sunbird_route_table_association,"private")
  dbsubents   = ["db", "db2"]
  cidr_block = "0.0.0.0/0"
  ingress_from_db_port = 3306
  ingress_to_db_port = 3306
  ingress_from_app_port = 8080
  ingress_to_app_port = 8080
  ingress_ssh_port = 22
  egress_from_port = 0
  egress_to_port = 65535
  proto = "tcp"
  allocated_storage = 20
  db_subnet_group_name = "sunbird_ntire"
  engine = "mysql"
  password = "rootroot"
  username = "sunbird"

}
