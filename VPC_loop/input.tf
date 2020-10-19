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
  default     = ["web", "app", "db", "mgmt"]
  description = "address range of primary"
}


