#resources creation for azure

resource "azurerm_resource_group" "ntire1"{

    name                = var.rs_name
    location            = var.location
    tags                = {
        Purpose         = "Learning",
        CreatedBy       = "Terraform"
    }

}

resource "azurerm_virtual_network" "nvnet1"{

    name                = "firstvnet1"
    resource_group_name = var.rs_name
    address_space       = [var.adspace]
    location            = var.location

    subnet{
        name            = var.subenet_name[0]
        address_prefix  = cidrsubnet(var.adspace, 8, 0)
    }
    subnet{
        name            = var.subenet_name[1]
        address_prefix  = cidrsubnet(var.adspace, 8, 1)
    }
    subnet{
        name            = var.subenet_name[2]
        address_prefix  = cidrsubnet(var.adspace, 8, 2)
    }
    subnet{
        name            = var.subenet_name[3]
        address_prefix  = cidrsubnet(var.adspace, 8, 3)
    }


    tags                = {
    environment         = "Production"
  }

depends_on              = [
    azurerm_resource_group.ntire1
  ]

}

#resources creation for aws

#creatig the VPC in aws
resource "aws_vpc" "myvpc" {
  cidr_block        = var.cidr_block
  tags = {
      Name      = var.tagname[0]
  }
}

#creating the subnets for web

resource "aws_subnet" "web"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 0)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sa", var.region)
  tags = {
  Name          = var.tagname[1]
  }
}
#creating the subnets for app


resource "aws_subnet" "app"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 1)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sb", var.region)
  tags = {
  Name          = var.tagname[2]
  }
}

#creating the subnets for db

resource "aws_subnet" "db"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 2)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sc", var.region)
  
  tags = {
  Name          = var.tagname[3]
  }
}

#creating the subnets for mgmt

resource "aws_subnet" "mgmt"{
  cidr_block    = cidrsubnet(var.cidr_block, 8, 3)
  vpc_id        = aws_vpc.myvpc.id
  availability_zone       = format("%sa", var.region)
  tags = {
  Name          = var.tagname[4]
  }
}
