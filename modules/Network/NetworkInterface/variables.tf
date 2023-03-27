variable "nicname" {
  type        = string
  description = "Name of the NSG group"
}

variable "location" {
  type = string
}
# variable "resourceGroupId" {
#   type        = string
#   description = "Resource group containing the NSG"
# }
variable "enable_accelerated_networking" {
  type = bool
}

variable "enable_ip_forwarding" {
  type = bool
}

variable "resource_group_name" {
  type = string
}

variable "ip_configuration" {
  type = list(object({
    name                          = string
    subnet_id_name                = string
    private_ip_address_allocation = string
    primary                       = bool
  }))
}

variable "SubNets" {
  type = any
}



# variable "SubNets" {
#   type = list(object({
#     id   = string
#     name = string
#   }))
# }
