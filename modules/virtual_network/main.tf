resource "azurerm_virtual_network" "myVnet" {
  name                = var.name
  address_space       = ["10.0.0.0/8"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

output "vnet_id" {
  value = azurerm_virtual_network.myVnet.id
}
