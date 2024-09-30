resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  azure_policy_enabled = true
  private_cluster_enabled = true

  default_node_pool {
    name       = "default"
    node_count = var.default_node_count
    vm_size    = var.vm_size
    vnet_subnet_id = var.subnet_id
    zones  = var.availability_zones
    tags = var.tags
  }
  

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }


  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
