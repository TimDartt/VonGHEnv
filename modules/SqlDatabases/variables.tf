variable "sqlID" {
  type        = string
  description = "The ID of the sql Server instance to attach the database to"
}


variable "databases" {
  type        = list(string)
  description = "The Databases to create on the server"
}
