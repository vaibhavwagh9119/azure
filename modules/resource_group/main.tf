resource "azurerm_resource_group" "aks_rg" {
  name     = var.name
  location = var.location
}

output "resource_group_name" {
  value = azurerm_resource_group.aks_rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.aks_rg.location
}
