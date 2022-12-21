variable "SQLSecRules" {
  description = "SQL Network security rules"
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

  default = [{
    name                       = "TestSQL"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "1433-1434"
    destination_port_range     = "1433-1434"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "*"
    },
    {
      name                       = "TestSQLUDP"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "1434"
      destination_port_range     = "1434"
      source_address_prefix      = "10.0.0.0/16"
      destination_address_prefix = "*"
  }]
}
