resource "azurerm_resource_group" "ntire"{

    name = "ntire"
    location = var.location
    tags            = {
        Purpose     = "Learning",
        CreatedBy   = "Terraform"
    }

}

resource azurerm_virtual_network ntire_vnet{

    name = "firstvnet"
    resource_group_name = azurerm_resource_group.ntire 
    address_space = var.addressspace
    location = var.location
    tags            = {
        Purpose     = "Learning",
        CreatedBy   = "Terraform"
    }



}