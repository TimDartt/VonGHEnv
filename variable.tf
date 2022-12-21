variable "environment" {
  type        = string
  default     = "Stg"
  description = "Staging target deployment area"
}

variable "dbNames" {
  type    = list(any)
  default = ["TestStgDB1", "TestStgDB2", "TestStgDB3"]
}

variable "instance" {
  type        = number
  default     = 0
  description = "The current instance of the item"
}
variable "default_tags" {
  type = map(string)
  default = {
    "Owner" = "VON"
  }
}
