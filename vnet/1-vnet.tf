resource "azurerm_virtual_network" "vnet" {
  depends_on = [var.resource_group]
  name                = "AKS-vnet"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  address_space       = ["10.0.0.0/16"]
}


resource "azurerm_subnet" "subnet_address_public" {
  depends_on = [azurerm_virtual_network.vnet]
  name                 = "public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet_address_nat" {
  depends_on = [azurerm_virtual_network.vnet]
  name                 = "nat"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}

