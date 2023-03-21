# first define the resource group and the rules that will be applied 
# resource "azurerm_network_security_group" "envSecGroup" {
#   name                = var.secGroupName
#   location            = var.location
#   resource_group_name = var.resourceGroup
#   security_rules = a set of rule to apply to the NSG
#   

resource "azurerm_network_security_group" "example" {
  name                = var.NSGName
  location            = var.Location
  resource_group_name = var.ResourceGroupName
  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      protocol                   = security_rule.value.protocol
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      source_port_range          = security_rule.value.source_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_port_range     = security_rule.value.destination_port_range
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

}
