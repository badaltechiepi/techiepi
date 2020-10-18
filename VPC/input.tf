#this varialbe defin the region
variable "region" {
  type        = string
  default     = "us-east-2"
  description = "region"
}

#this variable define the cidr_block(ip range)
variable cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr_block value"
}

#thid variable defind to get the vpc id(attribute)
variable vpc_id {
  type        = string
  default     = "aws_vpc.myvpc.id"
  description = "vpc id"
}

#tag name
variable tagname {
  type        = list(string)
  default     = ["myfistvpc","web","app","db","mgmt"]
  description = "tag names"
}



