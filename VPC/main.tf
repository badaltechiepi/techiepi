#creatig the VPC in aws
resource "aws_vpc" "myvpc" {
  cidr_block        = var.cidr_block
  tags = {
      Name      = var.vpcname
  }
}

#creating the subnets for web

resource "aws_subnet" "subnets"{
  count         = length(var.tagname)
  cidr_block    = cidrsubnet(var.cidr_block, 8, count.index)
  vpc_id        = aws_vpc.myvpc.id
  tags = {
  Name          = var.tagname[count.index]
  }
}