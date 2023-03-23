# # now create the vNet using the security group defined above
resource "azurerm_virtual_network" "curvNnet" {
  name                = var.networkName
  location            = var.location
  resource_group_name = var.resourceGroup
  address_space       = ["${var.BaseNet}${var.AddressSpace}"]
  #set the tags...  
  tags = merge(var.tags, { environment = "GlobalHealth" })
}

resource "azurerm_subnet" "vNetSubNets" {
  for_each             = { for index, item in var.SubNets : index => item }
  resource_group_name  = var.resourceGroup
  virtual_network_name = azurerm_virtual_network.curvNnet.name
  name                 = each.value["name"]
  address_prefixes     = ["${var.BaseNet}${each.value["address_prefix"]}"]
}

