variable primary_region {
  type        = string
  default     = "us-east-2"
  description = "The primary region for deploying aws resources"
}
variable cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc for aws"
}
variable subnets {
  type        = list(string)
  default     = ["web", "app", "db", "mgmt", "web2", "db2",]
  description = "address range of primary"
}

variable route_table_names{
  type = list(string)
  default = ["public", "private"]
  description = "creating public and private route table"
}

variable accosiation{
  type = map
  default = {

    public = [0,4,3]
    private = [1,2,5]

  }
}