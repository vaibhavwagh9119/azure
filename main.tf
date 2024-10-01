provider "azurerm" {
  features {}
  subscription_id = var.subscription
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = "aks-cluster-rg-01"
  location = var.location
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  name                = "myVnet"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  
}



module "aks_subnet" {
  source              = "./modules/subnets"
  name                = "aks-subnet"
  resource_group_name = module.resource_group.resource_group_name
  virtual_network_name = "myVnet"
  address_prefixes    = ["10.1.0.0/16"]
}

module "app_gateway_subnet" {
  source              = "./modules/subnets"
  name                = "app-gateway-subnets"
  resource_group_name = module.resource_group.resource_group_name
  virtual_network_name = "myVnet"
  address_prefixes    = ["10.2.0.0/24"]
}

module "vpn_gateway_subnet" {
  source              = "./modules/subnets"
  name                = "GatewaySubnet"
  resource_group_name = module.resource_group.resource_group_name
  virtual_network_name = "myVnet"
  address_prefixes    = ["10.0.0.0/24"]
}



module "aks_cluster" {
  source              = "./modules/aks_cluster"
  cluster_name        = "myAKSCluster"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = "myakscluster"
  default_node_count  = 1
  vm_size             = "Standard_DS2_v2"
  subnet_id           = module.subnets.aks_subnet_id
  availability_zones  = var.availability_zones
  tags =  { org = "aks" }
}
# App Gateway Subnet
resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "app-gateway-subnet"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = "myVnet"
  address_prefixes     = ["10.2.0.0/24"]
}

module "app_gateway" {
  source              = "./modules/app_gateway"
  app_gateway_name    = "example-app-gateway"
  public_ip_name      = "app-gateway-public-ip"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  subnet_id           = module.subnets.app_gateway_subnet_id

  sku_name               = "Standard_v2"
  sku_tier               = "Standard_v2"
  sku_capacity           = 2
  autoscale_min_capacity = 1
  autoscale_max_capacity = 3
}




