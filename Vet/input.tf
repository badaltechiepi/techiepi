variable rs_name {
  type        = string
  default     = "newrs"
  description = "description"
}



variable location {
  type        = string
  default     = "EastUS"
  description = "location to create the vnet"
}

variable adspace {
  type        = string
  default     = "10.10.0.0/16"
  description = "this is the address space"
}

variable subenet_name {
  type        = list(string)
  default     = ["web", "app", "db", "mgmt"]
  description = "subenet name"
}

