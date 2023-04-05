variable "ServicePlans" {
  description = "a list of all the service plans"
  type = list(object(
    { name                = string
      resource_group_name = string
      os_type             = string
      sku_name            = string
    }
  ))
}

variable "Location" {
  description = "Where to install the resource"
  type        = string
}
