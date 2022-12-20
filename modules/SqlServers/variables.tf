variable "sqlName" {
  type        = string
  description = ""
}

variable "resoureGroup" {
  type        = string
  description = ""
}

variable "location" {
  type        = string
  description = ""
}


variable "sqlLogin" {
  type        = string
  description = ""
}

variable "sqlPassword" {
  type        = string
  description = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "All the tags to pass to a module"
}

variable "databases" {
  type        = list(string)
  description = "The Databases to create on the server"
}
