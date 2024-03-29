output "test" {
  value = "Storage: ${var.sqlName}storage"
}
output "test2" {
  value = "SqlName: ${var.sqlName}"
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_storage_account" "SqlStorageAccount" {
  name                     = "sqlstore${random_string.random.result}"
  resource_group_name      = var.resoureGroup
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#define the server
resource "azurerm_mssql_server" "sqlInstance" {
  version                      = "12.0"
  name                         = var.sqlName
  resource_group_name          = var.resoureGroup
  location                     = var.location
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
