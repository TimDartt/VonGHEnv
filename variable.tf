variable "environment" {
  type        = string
  default     = "Stg"
  description = "Staging target deployment area"
}

variable "dbNames" {
  type    = list(any)
  default = ["TestStgDB1", "TestStgDB2", "TestStgDB3"]
}
