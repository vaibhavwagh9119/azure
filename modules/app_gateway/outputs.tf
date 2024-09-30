output "app_gateway_id" {
  value = azurerm_application_gateway.app_gateway.id
}

output "public_ip" {
  value = azurerm_public_ip.app_gateway_public_ip.id
}
