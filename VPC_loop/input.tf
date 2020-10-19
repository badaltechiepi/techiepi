variable cidr_block {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc for aws"
}
variable name {
  type        = string
  default     = ""
  description = "description"
}
variable subnets {
  type        = list(string)
  default     = ["web", "app", "db", "mgmt"]
  description = "address range of primary"
}


