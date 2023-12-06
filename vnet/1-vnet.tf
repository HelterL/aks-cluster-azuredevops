resource "azurerm_virtual_network" "vnet" {
  depends_on = [var.resource_group]
  name                = "AKS-vnet"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet_address_nat" {
  depends_on = [azurerm_virtual_network.vnet]
  name                 = "nat"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_public_ip_prefix" "nat_prefix" {
  name                = "ip-nat-gateway"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  ip_version          = "IPv4"
  prefix_length       = 31
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_ips" {
  nat_gateway_id      = azurerm_nat_gateway.natgateway.id
  public_ip_prefix_id = azurerm_public_ip_prefix.nat_prefix.id

}


resource "azurerm_nat_gateway" "natgateway" {
  name                = "natgateway"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_subnet_nat_gateway_association" "nat_association" {
  subnet_id      = azurerm_subnet.subnet_address_nat.id
  nat_gateway_id = azurerm_nat_gateway.natgateway.id
}

