#provider for azure

provider "azurerm"{
    version = "~>2.20.0"
    features{}
}

#adding the provider for aws
provider "aws" {
    region      = var.region
}