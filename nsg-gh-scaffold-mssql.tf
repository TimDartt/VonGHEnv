/*
Define the network security group rules for the 
GH-Scaffold MSSQL
*/

locals {
  nsg-gh-scaffold-mssql-Rules = [
    {
      name                       = "allow_tds_inbound"
      protocol                   = "*"
      priority                   = "1000"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = null
      source_address_prefix      = "*"
      destination_port_range     = ["1433"]
      destination_address_prefix = "10.150.70.0/24"
    }

  ]
}
