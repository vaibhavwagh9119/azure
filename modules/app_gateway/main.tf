resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = "app-gateway-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "app-gateway-public-ip"
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  frontend_ip_configuration {
    name                          = "app-gateway-private-ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation  = "Dynamic"
  }

  frontend_port {
    name = "app-gateway-port"
    port = 80
  }

  http_listener {
    name                           = "app-gateway-listener"
    frontend_ip_configuration_name = "app-gateway-public-ip"
    frontend_port_name             = "app-gateway-port"
    protocol                       = "Http"
  }

  backend_address_pool {
    name = "default-backend-pool"
  }

  backend_http_settings {
    name                  = "default-backend-http-settings"
    cookie_based_affinity  = "Disabled"
    port                   = 80
    protocol               = "Http"
    request_timeout        = 20
  }

  request_routing_rule {
    name                       = "app-gateway-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "app-gateway-listener"
    backend_address_pool_name  = "default-backend-pool"
    backend_http_settings_name = "default-backend-http-settings"
  }
}
