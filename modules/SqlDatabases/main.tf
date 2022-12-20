resource "azurerm_mssql_database" "createDatabases" {
  count = length(var.databases)
  name  = var.databases[count.index]
  #name           = var.sqlDBName
  server_id      = var.sqlID
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "S0"
  zone_redundant = false
  tags = {
    owner = "VON"
  }
}
