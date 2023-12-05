output "address_subnet_public_id" {
  value = azurerm_subnet.subnet_address_public.id
}
output "vnet" {
  value = azurerm_virtual_network.vnet
}