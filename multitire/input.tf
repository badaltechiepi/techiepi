#variable for azure

variable rs_name {
  type        = string
  default     = "ntire"
  description = "description"
}



variable location {
  type        = string
  default     = "EastUS"
  description = "location to create the vnet"
}

variable adspace {
  type        = string
  default     = "192.168.0.0/16"
  description = "this is the address space"
}

variable subenet_name {
  type        = list(string)
  default     = ["web", "app", "db", "mgmt"]
  description = "subenet name"
}

#variable for aws

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

#tag name
variable tagname {
  type        = list(string)
  default     = ["myfistvpc","web","app","db","mgmt"]
  description = "tag names"
}

