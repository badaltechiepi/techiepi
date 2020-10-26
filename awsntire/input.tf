#variable to create the region
variable region {
  type        = string
  default     = "us-east-2"
  description = "default region"
}
#variable to set the IP
variable sunbird_cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr_block"
}
#variable to create the subnets
variable subnird_subnets {
  type        = list(string)
  default     = ["web", "app" ,"mgmt","web2" ,"db","db2","app2"]
  description = "subents to be created"
}
#variable to create the routing table
variable sunbird_route_table_names {
  type        = list(string)
  default     = ["public" , "private"]
  description = "rout table to be create"
}
#association the subnets with the routing table
variable sunbird_route_table_association{

  type  = map
  default   ={
    public  = [0,2,3]
    private = [1,4,5,6]
  }
  description = "associated the subnent with the route table"
}
#DB subnet name
variable db_subnet_name {
  type        = string
  default     = "allow_mysql"
  description = "db_subnet_name"
}
#App subnet name
variable app_subnet_name {
  type        = string
  default     = "allow_app"
  description = "app_subnet_name"
}

variable engine_version {
  type        = string
  default     = "8.0.20"
  description = "description"
}
variable identifier {
  type        = string
  default     = "lt-ntier-primary"
  description = "description"
}
variable instance_class {
  type        = string
  default     = "db.t2.micro"
  description = "description"
}
variable multi_az {
  type        = bool
  default     = false
  description = "description"
}
variable Name {
  type        = string
  default     = "sunbird_lthrms"
  description = "description"
}
variable ec2_ami {
  type        = string
  default     = "ami-0e82959d4ed12de3f"
  description = "EC2 AMI"
}
variable instance_type {
  type        = string
  default     = "t2.micro"
  description = "instance type"
}
variable key_name {
  type        = string
  default     = "terraform"
  description = "key name "
}
variable instance_name {
  type        = string
  default     = "tomcat-app-server"
  description = "instance name"
}








