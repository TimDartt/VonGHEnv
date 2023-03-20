variable "resourceGroup" {
  description = "Name of the resource group where this will live"
  type        = string
}

variable "location" {
  description = "Where the Resource is located"
  type        = string
  default     = "eastus"
}


variable "networkName" {
  type        = string
  description = "the name of the virtual network being being built"
}

variable "AddressSpace" {
  type        = string
  description = "The default address space for the network (not including the base Net address)"
}
variable "BaseNet" {
  type        = string
  description = "The base network address for the environment"
}


variable "tags" {
  type        = map(string)
  default     = {}
  description = "All the tags to pass to a module test"
}





# variable "secGroupName" {
#   description = "Name of the sec group to create"
#   type        = string
# }


# #The following allows for a list of rules to be created and feed into the Sec group creation
# variable "security_rules" {
#   description = "A list of security rules"
#   type = list(object({
#     name                       = string
#     priority                   = number
#     direction                  = string
#     access                     = string
#     protocol                   = string
#     source_port_range          = string
#     destination_port_range     = string
#     source_address_prefix      = string
#     destination_address_prefix = string
#   }))
# }

# variable "SubNets" {
#   type = map(object({
#     name           = string
#     address_prefix = string
#   }))
#   description = "Subnets for the vNet"
# }


