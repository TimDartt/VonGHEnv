resource "azurerm_application_security_group" "ASGs" {
  location            = var.location
  for_each            = { for index, item in var.ASGGroups : index => item }
  name                = each.value.ASGName
  resource_group_name = each.value.ResourceGroup
  tags                = merge(each.value.tags, var.tags)
}
