variable "PublicIPS" {
  type = list(object(
    { name                = string
      resource_group_name = string
      allocation_method   = string
  }))
  description = "A set of Public IP's to create"
}

variable "Location" {
  type        = string
  description = "Where to create the resource"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "All the tags to pass to a module test"
}
