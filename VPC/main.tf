#creatig the VPC in aws
resource "aws_vpc" "myvpc" {
  cidr_block        = "192.168.0.0/16" 
  tags = {
      name      = "fistvpc"
  }
}

