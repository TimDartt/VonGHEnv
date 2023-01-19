variable "environment" {
  type        = string
  default     = "Stg"
  description = "Staging target deployment area"
}

variable "dbNames" {
  type    = list(any)
  default = ["VonApp", "GH_PHI"]
}

variable "instance" {
  type        = number
  default     = 0
  description = "The current instance of the item"
}
# variable "default_tags" {
#   type = map(string)
#   default = {
#     "Owner"       = "VON"
#     "environment" = "${var.environment}"
#   }
# }
