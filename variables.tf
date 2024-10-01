variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned"
}

variable "subscription" {
  description = "The subscription ID for your Azure account"
}

variable "availability_zones" {
  description = "The availability zones for the AKS cluster."
  type        = list(string)
}

