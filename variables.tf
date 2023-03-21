variable "environment" {
  type        = string
  default     = "Dev"
  description = "Dev target deployment area"
}

#List all the Database to associate with the SQL instance
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

###### Variables that are set in Terraform Cloud Build
variable "BaseNet" {
  type        = string
  description = "The base network address for the environment"
}
variable "Env" {
  type        = string
  description = "The environment being built"

}

variable "sqlLogin" {
  type        = string
  description = ""
}

variable "sqlPassword" {
  type        = string
  description = ""
}
