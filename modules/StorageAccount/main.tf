#TODO: Review to see if the specificity for Sql is needed just for Sql storage...

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

# resource "azurerm_storage_account" "example" {
#   name                     = "${lower(var.base_name)}${random_string.random.result}"
#   resource_group_name      = var.resource_group_name
#   location                 = var.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"
# }

resource "azurerm_mssql_elasticpool" "sqlElasticPool" {
  name                = "${lower(var.base_name)}${random_string.random.result}ElasticPool"
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.sqlName
  max_size_gb         = 50

  sku {
    name     = "BasicPool"
    tier     = "Basic"
    capacity = 4
  }

  per_database_settings {
    min_capacity = 0.25
    max_capacity = 4
  }
}
