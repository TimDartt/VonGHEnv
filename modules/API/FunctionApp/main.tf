resource "azurerm_windows_function_app" "GHFunctionApps" {
  location                   = var.location
  for_each                   = { for index, item in var.FunctionApps : index => item }
  name                       = "${each.value.name}${var.Env}"
  resource_group_name        = each.value.resource_group_name
  storage_account_name       = "${each.value.storage_account_name}${var.StorgeInfoRandom}"
  storage_account_access_key = var.StorageAccounts["${each.value.storage_account_name}${var.StorgeInfoRandom}"].primary_access_key
  service_plan_id            = var.ServicePlans[each.value.ServicePlan].id
  site_config {}
}
