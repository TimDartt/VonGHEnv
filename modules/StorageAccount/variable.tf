variable "base_name" {
  type        = string
  description = "Storage account base name"
}
variable "resource_group_name" {
  type        = string
  description = "Storage account resource group"
}
variable "location" {
  type        = string
  description = "Storage account location"
}
variable "sqlName" {
  type        = string
  description = "Name of the sqlServer to associate the pool with"
}
