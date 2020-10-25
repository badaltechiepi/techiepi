#associated public and private route table accrodingly. to achive this we will using map variable along with lookup function.
# to store the value we are using the local(defind variable to store the value locally inside the template) 
#Public(web,mgmt,web2)
#count only take the index and the public subnet store the values like 0,3,4
#When we do the itration so it will itrate the values like 0,3,4 

locals{

  public_subnet = lookup(var.sunbird_route_table_association,"public")
  private_subnet = lookup(var.sunbird_route_table_association,"private")
  dbsubents   = ["db", "db2"]
}
