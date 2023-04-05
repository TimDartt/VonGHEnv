variable "FunctionApps" {
  type = list(object({
    name                 = string
    resource_group_name  = string
    storage_account_name = string
    ServicePlan          = string
  }))

  default = [{
    name                 = "vonGHFunctions"
    resource_group_name  = "ghfunctions"
    storage_account_name = "ghfunction"
    ServicePlan          = "ASP-vonGHFunctions-9562"

  }]
}
