output "test" {
  value = "Storage: ${var.sqlName}-storage"
}
output "test2" {
  value = "SqlName: ${var.sqlName}"
}

module "sqlStorage" {
  source              = "../StorageAccount"
  location            = var.location
  resource_group_name = var.resoureGroup
  base_name           = "${replace(var.sqlName, "-", "")}str"
}

resource "azurerm_mssql_server" "sqlInstance" {
  name                         = var.sqlName
  resource_group_name          = var.resoureGroup
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sqlLogin
  administrator_login_password = var.sqlPassword
  tags                         = var.tags
}


#loop though the databases and create whats passed
module "createDBs" {
  source    = "../SqlDatabases"
  sqlID     = azurerm_mssql_server.sqlInstance.id
  databases = var.databases
}

resource "azurerm_mssql_firewall_rule" "sqlTraffic" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.sqlInstance.id
  start_ip_address = "216.238.165.18"
  end_ip_address   = "216.238.165.18"
}

resource "azurerm_mssql_firewall_rule" "sqlTraffic2" {
  name             = "FirewallRule2"
  server_id        = azurerm_mssql_server.sqlInstance.id
  start_ip_address = "66.211.134.66"
  end_ip_address   = "66.211.134.66"
}


# this works:
# resource "azurerm_mssql_database" "test" {
#   name           = "testSqlDB"
#   server_id      = azurerm_mssql_server.sqlInstance.id
#   collation      = "SQL_Latin1_General_CP1_CI_AS"
#   license_type   = "LicenseIncluded"
#   max_size_gb    = 2
#   sku_name       = "S0"
#   zone_redundant = false
#   tags = {
#     owner = "VON"
#   }
# }




