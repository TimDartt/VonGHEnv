variable "StorageAccounts" {
  description = "A list of all the storage accounts to create"
  type = list(object({
    name                     = string
    resource_group_name      = string
    account_tier             = string
    account_replication_type = string
    account_kind             = string
    })
  )
}

variable "Location" {
  description = "Where the resource should be created"
  type        = string
}

variable "Tags" {
  description = "All the tags to pass to a module test"
  type        = map(string)
  default     = {}
}
