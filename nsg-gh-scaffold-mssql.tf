/*
Define the network security group rules for the 
GH-Scaffold MSSQL
*/

locals {
  nsg-gh-scaffold-mssql-Rules = {
    r1 = {
      Name                       = "allow_tds_inbound"
      protocol                   = "*"
      priority                   = "1000"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      destination_port_range     = "1433"
      destination_address_prefix = "10.150.70.0/24"
    },
    r2 = {
      Name                       = "allow_redirect_inbound"
      protocol                   = "*"
      priority                   = "1100"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      destination_port_range     = "11000-11999"
      destination_address_prefix = "10.150.70.0/24"
    },
    r3 = {
      Name                       = "allow_geodr_inbound"
      protocol                   = "*"
      priority                   = "1200"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      destination_port_range     = "5022"
      destination_address_prefix = "10.150.70.0/24"
    }
  }
}
