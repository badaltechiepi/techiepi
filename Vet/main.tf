resource "azurerm_resource_group" "ntire"{

    name = var.rs_name
    location = var.location
    tags            = {
        Purpose     = "Learning",
        CreatedBy   = "Terraform"
    }

}

resource "azurerm_virtual_network" "nvnet"{

    name = "firstvnet"
    resource_group_name = var.rs_name
    address_space = [var.adspace]
    location = var.location
    tags            = {
        Purpose     = "Learning",
        CreatedBy   = "Terraform"
    }



}