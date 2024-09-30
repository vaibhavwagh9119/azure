variable "cluster_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "default_node_count" {
  type = number
}

variable "vm_size" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "enable_azure_policy" {
  description = "Enable or disable Azure Policy for the AKS cluster"
  type        = bool
  default     = true
}