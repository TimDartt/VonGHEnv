# create all the private DNS zones in the set
resource "azurerm_private_dns_zone" "PrivateDNSZones" {
  for_each            = { for index, item in var.PrivateDNSZones : index => item }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# now we need to go and create all the record sets....

