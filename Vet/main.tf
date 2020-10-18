resource "azurerm_resource_group" "ntire1"{

    name                = var.rs_name
    location            = var.location
    tags                = {
        Purpose         = "Learning",
        CreatedBy       = "Terraform"
    }

}

resource "azurerm_virtual_network" "nvnet1"{
    
    count               =  length(var.subenet_name)
    name                = "vnetfirst"
    resource_group_name = var.rs_name
    address_space       = [var.adspace]
    location            = var.location
    subnet{
        #index need to 0,1,2,3
        name            = var.subenet_name[count.index] 
        address_prefix  = cidrsubnet(var.adspace, 8, count.index) 
    }

    tags                = {
    environment         = "Production"
  }

depends_on              = [
    azurerm_resource_group.ntire1
  ]

}