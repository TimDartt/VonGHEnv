resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "StorageAccountResource" {
  location                 = var.Location
  for_each                 = { for index, item in var.StorageAccounts : index => item }
  name                     = "${each.value.name}${random_string.random.result}"
  resource_group_name      = each.value.resource_group_name
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  account_kind             = each.value.account_kind
  tags                     = var.Tags
}

