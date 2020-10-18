variable "region" {
  type        = string
  default     = "us-east-2"
  description = "region"
}

variable vpc {
  type        = string
  default     = "192.168.0.0/16"
  description = "cidr_block value"
}
