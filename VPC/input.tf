#this varialbe defin the region
variable "region" {
  type        = string
  default     = "us-east-2"
  description = "region"
}

variable vpcname {
  type        = string
  default     = "myfirstc"
  description = "this is my first vpc"
}


#this variable define the cidr_block(ip range)
variable cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr_block value"
}

#tag name
variable tagname {
  type        = list(string)
  default     = ["web","app","db","mgmt"]
  description = "tag names"
}



