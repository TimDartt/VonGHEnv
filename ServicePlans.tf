variable "ServicePlans" {
  type = list(object(
    { name                = string
      resource_group_name = string
      os_type             = string
      sku_name            = string
    }
  ))
  default = [{
    name                = "ASP-vonGHFunctions-9562"
    os_type             = "Windows"
    resource_group_name = "GHFunctions"
    sku_name            = "EP1"
  }]

}
