variable region {
  type        = string
  default     = "us-east-2"
  description = "default region"
}
variable sunbird_cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr_block"
}
variable subnird_subnets {
  type        = list(string)
  default     = ["web", "app" ,"mgmt",,"web2" ,"db","db2","app2"]
  description = "subents to be created"
}
variable sunbird_route_table_names {
  type        = list(string)
  default     = ["public" , "private"]
  description = "rout table to be create"
}

variable sunbird_route_table_association{

  type  = map
  default   ={
    public  = [0,2,3]
    private = [1,4,5,6]
  }
  description = "associated the subnent with the route table"
}


