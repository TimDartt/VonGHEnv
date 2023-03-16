#The following allows for a list of rules to be created and feed into the Sec group creation
variable "security_rules" {
  description = "A list of security rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "NSGName" {
  type        = string
  description = "Name of the NSG group"
}

variable "Location" {
  type = string
}
variable "ResourceGroupName" {
  type        = string
  description = "Resource group containing the NSG"
}
