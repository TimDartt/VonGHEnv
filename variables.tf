variable "environment" {
  type        = string
  default     = "Dev"
  description = "Dev target deployment area"
}
variable "location" {
  type        = string
  description = "The default location to build our resources"
  default     = "eastus"
}

#List all the Database to associate with the SQL instance
variable "dbNames" {
  type        = list(any)
  description = "A list of the databases to create with our sql instance"
  default     = ["VonApp", "VonTest"] #Note: currently we only really need VonApp but I have two listed to test processes
}

# we discussed at one point numbering each instance to allow for N dev environments.... we can work on this later when time permits
variable "instance" {
  type        = number
  default     = 0
  description = "The current instance of the item"
}

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
