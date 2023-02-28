# first define the resource group and the rules that will be applied 
resource "azurerm_network_security_group" "envSecGroup" {
  name                = var.secGroupName
  location            = var.location
  resource_group_name = var.resourceGroup

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# now create the vNet using the security group defined above
resource "azurerm_virtual_network" "test" {
  name                = var.networkName
  location            = var.location
  resource_group_name = var.resourceGroup
  address_space       = ["10.150.0.0/16"]
  subnet {
    name           = "gh-public-1"
    address_prefix = "10.150.60.0/24"
  }
  subnet {
    name           = "gh-private-1"
    address_prefix = "10.150.70.0/24"
  }
  subnet {
    name           = "gh-internal-1"
    address_prefix = "10.150.80.0/24"
  }
  subnet {
    name           = "core-routing"
    address_prefix = "10.150.50.0/24"
    security_group = azurerm_network_security_group.envSecGroup.id
  }
  tags = {
    environment = "GlobalHealth"
  }
}

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
