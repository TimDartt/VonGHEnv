variable "PrivateDNSZones" {
  description = "A List of all the private DNS Zones"
  type = list(object(
    {
      name                = string
      resource_group_name = string
    }
  ))
}

# variable "Location" {
#   description = "Where the resource should be created"
#   type        = string
# }

# variable "Tags" {
#   description = "All the tags to pass to a module test"
#   type        = map(string)
#   default     = {}
# }

