#creatig the VPC in aws
resource "aws_vpc" "myvpc" {
  cidr_block        = "192.168.0.0/16" 
  tags = {
      Name      = "fistvpc"
  }
}

#creating the subnets as discussed

resource "aws_subnet" "web"{
  cidr_block    = "192.168.0.0/24"
  vpc_id        = "aws_vpc.myvpc.id"
  tags {
  Name          = "web"
  }
}

