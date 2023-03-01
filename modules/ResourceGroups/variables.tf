variable "ResourceGroupName" {
  description = "Name of the resource group"
  type        = string
}
variable "ResourceLocation" {
  description = "location to use for the resource"
  type        = string

}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "All the tags to pass to a module test"
}
