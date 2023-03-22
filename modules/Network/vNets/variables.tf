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

variable "SubNets" {
  type = map(object({
    name           = string
    address_prefix = string
  }))
  description = "Subnets for the vNet"
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





