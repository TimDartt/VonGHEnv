variable "FunctionApps" {
  type = list(object({
    name                 = string
    resource_group_name  = string
    storage_account_name = string
    ServicePlan          = string
  }))
}

variable "location" {
  description = "Where to build the resource"
  type        = string
}

variable "StorageAccounts" {
  description = "The Storage account Information"
  type        = any
}
variable "Env" {
  description = "Current build environment"
  type        = string
}

variable "ServicePlans" {
  description = "A list or all the service plans created"
  type        = any
}

variable "StorgeInfoRandom" {
  description = "The random variable used to create the storage account"
  type        = string
}
