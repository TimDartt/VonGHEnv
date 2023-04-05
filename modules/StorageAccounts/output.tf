# pass back a key value set of info to use in reference to the storage accounts in other modules
output "StorageAccountInfoKV" {
  value = {
    for sa in azurerm_storage_account.StorageAccountResource : sa.name => { id = sa.id, name = sa.name, primary_access_key = sa.primary_access_key }
  }
}

# pass out the Random string used to create the account names to enable referencing in other modules
output "StorgeInfoRandom" {
  value = local.StorageRandom
}
