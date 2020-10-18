resource "azurerm_resource_group" "ntire1"{

    name = var.rs_name
    location = var.location
    tags            = {
        Purpose     = "Learning",
        CreatedBy   = "Terraform"
    }

}

resource "azurerm_virtual_network" "nvnet1"{

    name = "firstvnet1"
    resource_group_name = var.rs_name
    address_space = [var.adspace]
    location = var.location

    subnet{
        name = var.subenet_name[0]
        address_prefix = cidrsubnet("192.168.0.0/16",8,0)
    }
    subnet{
        name = var.subenet_name[1]
        address_prefix = cidrsubnet("192.168.0.0/16",8,1)
    }
    subnet{
        name = var.subenet_name[2]
        address_prefix = cidrsubnet("192.168.0.0/16",8,2)
    }
    subnet{
        name = var.subenet_name[3]
        address_prefix = cidrsubnet("192.168.0.0/16",8,3)
    }


    tags            = {
        Purpose     = "Learning",
        CreatedBy   = "Terraform"
    }

depends_on = [
    azurerm_resource_group.ntire1
  ]

}