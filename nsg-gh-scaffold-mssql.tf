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
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["1433"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "allow_redirect_inbound"
      protocol                   = "*"
      priority                   = "1100"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["11000-11999"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "allow_geodr_inbound"
      protocol                   = "*"
      priority                   = "1200"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["5022"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "allow_linkedserver_outbound"
      protocol                   = "*"
      priority                   = "1000"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["1433"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "allow_redirect_outbound"
      protocol                   = "*"
      priority                   = "1100"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["11000-11999"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "allow_geodr_outbound"
      protocol                   = "*"
      priority                   = "1200"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["5022"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "allow_privatelink_outbound"
      protocol                   = "*"
      priority                   = "1300"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["443"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "allow_azurecloud_outbound"
      protocol                   = "*"
      priority                   = "1400"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["443"]
      destination_address_prefix = "AzureCloud"
    },
    {
      name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-10-150-70-0-24-v10"
      protocol                   = "*"
      priority                   = "100"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["9000", "9003", "1438", "1440", "1452"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-10-150-70-0-24-v10"
      protocol                   = "*"
      priority                   = "101"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["9000", "9003", "1440"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-10-150-70-0-24-v10"
      protocol                   = "*"
      priority                   = "102"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["9000", "9003"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-10-150-70-0-24-v10"
      protocol                   = "*"
      priority                   = "103"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-10-150-70-0-24-v10"
      protocol                   = "*"
      priority                   = "104"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-10-150-70-0-24-v10"
      protocol                   = "*"
      priority                   = "100"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["443", "12000"]
      destination_address_prefix = "AzureCloud"
    },
    {
      name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-10-150-70-0-24-v10"
      protocol                   = "*"
      priority                   = "101"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "10.150.70.0/24"
    },
    {
      name                       = "AllowPublicSubnet1433Inbound"
      protocol                   = "*"
      priority                   = "1300"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["1433"]
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowCidrBlockCustomAnyInbound-DF-SQL"
      protocol                   = "*"
      priority                   = "1350"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "*"
    },
    {
      name                       = "Data_Factory_Inbound"
      protocol                   = "*"
      priority                   = "105"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["1433", "3342"]
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowVnetInBound"
      protocol                   = "*"
      priority                   = "4095"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "AllowAzureLoadBalancerInBound"
      protocol                   = "*"
      priority                   = "4096"
      direction                  = "Inbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "*"
    },
    {
      name                       = "DenyAllInBound"
      protocol                   = "*"
      priority                   = "4095"
      direction                  = "Inbound"
      access                     = "Deny"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowVnetOutBound"
      protocol                   = "*"
      priority                   = "4095"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "AllowInternetOutBound"
      protocol                   = "*"
      priority                   = "4096"
      direction                  = "Outbound"
      access                     = "Allow"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "Internet"
    },
    {
      name                       = "DenyAllOutBound"
      protocol                   = "*"
      priority                   = "4095"
      direction                  = "Outbound"
      access                     = "Deny"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = ["*"]
      destination_address_prefix = "*"
    }



  ]
}
