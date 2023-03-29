resource "azurerm_private_dns_a_record" "ARecords" {
  for_each            = { for index, item in var.ARecords : index => item }
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
}
