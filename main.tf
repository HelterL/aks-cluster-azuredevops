terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.83.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "storagedesafiotf"
    container_name       = "tfstate"
    key                  = "azuredevops.tfstate"
  }
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
  }
  } 
  skip_provider_registration = true
}



module "resource_group" {
  source = "./resource_group"
}

module "vnet" {
  source = "./vnet"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  resource_group = module.resource_group.resource_group
 }

module "aks" {
  source = "./aks"
  resource_group_location = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  vnet = module.vnet.vnet
  address_subnet_nat = module.vnet.address_subnet_nat
}