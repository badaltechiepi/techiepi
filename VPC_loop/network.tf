resource "aws_vpc" "myvpc"{
    cidr_block = var.cidr_block
    tags = {
    Name = "ntier primary"
  }
}
#lengthfunction doesn't has squre bracket
resource "aws_subnet" "mysubnet"{
    vpc_id     = aws_vpc.myvpc.id
    count      = length(var.subnets)
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
     tags = {
    Name = var.subnets[count.index]
  }
}
#data source example
data "aws_vpc" "selected" {
  cidr_block = var.cidr_block
}

#creating a extra subnet

resource "aws_subnet" "extra"{

    vpc_id = data.aws_vpc.selected.cidr_block
    cidr_block        = cidrsubnet(data.aws_vpc.selected.cidr_block, 8, 4)
    tags = {
    Name = "extra"
  }

}



