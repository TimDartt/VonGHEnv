# variable "nsg-gh-scaffold-mssql-Rules" {
#   description = "nsg-gh-scaffold-mssql network security rules"
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
#   default = [
#     {
#       Name                       = "allow_tds_inbound"
#       priority                   = "1000"
#       direction                  = "Inbound"
#       access                     = "Allow"
#       source_port_range          = "*"
#       destination_port_range     = "1433"
#       destination_address_prefix = "10.150.70.0/24"
#     },
#     {
#       Name                       = "allow_redirect_inbound"
#       priority                   = "1100"
#       direction                  = "Inbound"
#       access                     = "Allow"
#       source_port_range          = "*"
#       destination_port_range     = "11000-11999"
#       destination_address_prefix = "10.150.70.0/24"
#     },
#     {
#       Name                       = "allow_geodr_inbound"
#       priority                   = "1200"
#       direction                  = "Inbound"
#       access                     = "Allow"
#       source_port_range          = "*"
#       destination_port_range     = "5022"
#       destination_address_prefix = "10.150.70.0/24"
#     }
#   ]
# }
