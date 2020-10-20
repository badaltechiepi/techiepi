#vpc creation
resource "aws_vpc" "myvpc"{
    cidr_block = var.cidr_block
    tags = {
    Name = "ntier primary"
  }
}
#subnet creation
resource "aws_subnet" "mysubnet"{
    vpc_id     = aws_vpc.myvpc.id
    count      = length(var.subnets)
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
     tags = {
    Name = var.subnets[count.index]
  }
}
#let's create the internet gateway

resource "aws_internet_gateway" "ntire" {
  vpc_id     = aws_vpc.myvpc.id
  tags = {
    Name = "ntiregw"
  }

  depends_on = [
     aws_subnet.ntier 
  ]
}


