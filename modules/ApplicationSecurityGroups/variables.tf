variable "ASGGroups" {
  type = list(object({
    ASGName       = string
    ResourceGroup = string
    tags          = map(string)
  }))
}

variable "location" {
  type        = string
  description = "Location where the resource should be created"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "All the tags to pass to a module test"
}
