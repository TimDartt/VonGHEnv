variable "StorageAccounts" {
  description = "a list of all the storage accounts in use"
  type = list(object({
    name                     = string
    resource_group_name      = string
    account_tier             = string
    account_replication_type = string
    account_kind             = string
    })
  )
  default = [
    {
      name                     = "ghfunctionsbc7c"
      resource_group_name      = "GHFunctions"
      account_tier             = "Standard"
      account_replication_type = "RAGRS"
      account_kind             = "Storage"
    }
    , {
      name                     = "ghscaffolddfstorage"
      resource_group_name      = "gh-scaffold-storage"
      account_tier             = "Standard"
      account_replication_type = "RAGRS"
      account_kind             = "StorageV2"
    }
    , {
      name                     = "sqlvazjy37v2w3yqcs"
      resource_group_name      = "gh-scaffolding-database"
      account_tier             = "Standard"
      account_replication_type = "RAGRS"
      account_kind             = "StorageV2"
    }
  ]
}
