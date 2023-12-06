output "address_subnet_nat" {
  value = azurerm_subnet.subnet_address_nat.id
}
output "vnet" {
  value = azurerm_virtual_network.vnet
}