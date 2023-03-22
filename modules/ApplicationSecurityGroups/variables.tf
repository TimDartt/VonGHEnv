variable "ASGGroups" {
  type = list(object({
    ASGName       = string
    ResourceGroup = string
  }))
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "All the tags to pass to a module test"
}
