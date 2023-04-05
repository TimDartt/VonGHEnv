resource "azurerm_service_plan" "ServicePlansRG" {
  location            = var.Location
  for_each            = { for index, item in var.ServicePlans : index => item }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}
