variable "app_gateway_name" {
  type        = string
  description = "Name of the Application Gateway"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP for Application Gateway"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the Application Gateway will be deployed"
}

variable "sku_name" {
  type        = string
  description = "SKU name for the Application Gateway"
  default     = "Standard_v2"
}

variable "sku_tier" {
  type        = string
  description = "SKU tier for the Application Gateway"
  default     = "Standard_v2"
}

variable "sku_capacity" {
  type        = number
  description = "SKU capacity for the Application Gateway"
  default     = 2
}

variable "autoscale_min_capacity" {
  type        = number
  description = "Minimum capacity for autoscale"
  default     = 1
}

variable "autoscale_max_capacity" {
  type        = number
  description = "Maximum capacity for autoscale"
  default     = 3
}


