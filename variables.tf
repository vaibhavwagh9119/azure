variable "location" {
  default     = "East US"
  description = "The Azure Region in which all resources in this example should be provisioned"
}

variable "subscription" {
  default     = "50a1390f-363e-4a28-aa4f-941af322a11c"
}

variable "availability_zones" {
  description = "The availability zones for the AKS cluster."
  type        = list(string)
  default     = ["1", "2", "3"]
}