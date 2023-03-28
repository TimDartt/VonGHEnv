variable "GatewayName" {
  type        = string
  description = "Name of the local gateway"
}

variable "ResourceGroup" {
  type        = string
  description = "Resource group to associate the gateway with"
}
variable "AddressSpace" {
  type        = list(string)
  description = "The gateway address space"
}

variable "Location" {
  type        = string
  description = "value"
}

variable "GatewayAddress" {
  type        = string
  description = "The address of the gateway"
}
