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
  default     = ["web", "app" ,"mgmt", "db"]
  description = "subents to be created"
}

