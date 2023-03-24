# von-gh-scaffold-monitor-nsg
variable "von-gh-scaffold-monitor-nsg" {
  description = "A list of security rules"
  type = list(object({
    name                       = string
    protocol                   = string
    priority                   = number
    direction                  = string
    access                     = string
    source_port_range          = list(string)
    source_address_prefix      = string
    destination_port_range     = list(string)
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "default-allow-rdp"
      protocol                   = "*"
      priority                   = "1000"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["3389"]
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowCidrBlockRDPInbound"
      protocol                   = "*"
      priority                   = "100"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["3389"]
      destination_address_prefix = "10.150.80.13"
    },
    {
      name                       = "AllowCidrBlockRDPInbound-servers"
      protocol                   = "*"
      priority                   = "1010"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["3389"]
      destination_address_prefix = "10.150.80.13"
    },
    {
      name                       = "AllowCidrBlockRDPInboundservers"
      protocol                   = "*"
      priority                   = "110"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["3389"]
      destination_address_prefix = "10.150.80.0/24"
    },
    {
      name                       = "AllowVnetInBound"
      protocol                   = "*"
      priority                   = "4094"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["0-65535"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "AllowAzureLoadBalancerInBound"
      protocol                   = "*"
      priority                   = "4095"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["0-65535"]
      destination_address_prefix = "*"
    },
    {
      name                       = "DenyAllInBound"
      protocol                   = "*"
      priority                   = "4096"
      direction                  = "Inbound"
      access                     = "Deny"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["0-65535"]
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowVnetOutBound"
      protocol                   = "*"
      priority                   = "4094"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["0-65535"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "AllowInternetOutBound"
      protocol                   = "*"
      priority                   = "4095"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["0-65535"]
      destination_address_prefix = "Internet"
    },
    {
      name                       = "DenyAllOutBound"
      protocol                   = "*"
      priority                   = "4096"
      direction                  = "Outbound"
      access                     = "Deny"
      source_port_range          = ["0-65535"]
      source_address_prefix      = "*"
      destination_port_range     = ["0-65535"]
      destination_address_prefix = "*"
    }

  ]
}
