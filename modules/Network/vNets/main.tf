
# # now create the vNet using the security group defined above
resource "azurerm_virtual_network" "curvNnet" {
  name                = var.networkName
  location            = var.location
  resource_group_name = var.resourceGroup
  address_space       = ["${var.BaseNet}0.0/16"]
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

# locals {
#   ack = "AzureFirewallManagement"
# }
# output "Test" {
#   value = "Subnet:${azurerm_subnet.vNetSubNets.subnet[locals.ack].name} "
# }
#test of a different approach
# for_each = [for sr in var.security_rules : {
#   name                       = sr.name
#   priority                   = var.subNet * 1000 + sr.priority
#   direction                  = sr.direction
#   access                     = sr.access
#   protocol                   = sr.protocol
#   source_port_range          = sr.source_port_range
#   destination_port_range     = sr.destination_port_range
#   source_address_prefix      = sr.source_address_prefix      //replace(sr.source_address_prefix, "x", var.subNet)
#   destination_address_prefix = sr.destination_address_prefix // replace(sr.destination_address_prefix, "x", var.subNet)
# }]
# #{ for sg in var.security_rules : sg.name => sg }
# content {
#   name                       = security_rule.value.name
#   priority                   = security_rule.value.priority
#   direction                  = security_rule.value.direction
#   access                     = security_rule.value.access
#   protocol                   = security_rule.value.protocol
#   source_port_range          = security_rule.value.source_port_range
#   destination_port_range     = security_rule.value.destination_port_range
#   source_address_prefix      = security_rule.value.source_address_prefix
#   destination_address_prefix = security_rule.value.destination_address_prefix
# }

# name                       = security_rule.value["name"]
# priority                   = var.subNet * 1000 + security_rule.value["priority"]
# direction                  = security_rule.value["direction"]
# access                     = security_rule.value["access"]
# protocol                   = security_rule.value["protocol"]
# source_port_range          = security_rule.value["source_port_range"]
# destination_port_range     = security_rule.value["destination_port_range"]
# source_address_prefix      = replace(security_rule.value["source_address_prefix"], "x", var.subNet)
# destination_address_prefix = replace(security_rule.value["destination_address_prefix"], "x", var.subNet)
