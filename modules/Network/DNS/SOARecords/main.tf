resource "azurerm_private_dns_soa_record" "SOARecords" {
  for_each            = { for index, item in var.SOARecords : index => item }
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
}
