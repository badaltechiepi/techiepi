variable rs_name {
  type        = string
  default     = "ntire"
  description = "description"
}



variable location {
  type        = string
  default     = "East US 2"
  description = "location to create the vnet"
}

variable adspace {
  type        = string
  default     = "192.168.0.0/16"
  description = "this is the address space"
}

variable subenet_name {
  type        = list(string)
  default     = ["web","app","db","mgmt"]
  description = "subenet name"
}

