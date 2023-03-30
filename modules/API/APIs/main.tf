resource "azurerm_api_management_api" "APIsRG" {
  for_each            = { for index, item in var.APIs : index => item }
  name                = each.value.name
  resource_group_name = each.value.ResourceGroupName
  api_management_name = "${each.value.api_management_name}-${var.Env}"
  revision            = each.value.revision
  display_name        = each.value.display_name
  path                = each.value.Path
  protocols           = each.value.protocols
}
