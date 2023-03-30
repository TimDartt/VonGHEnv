variable "APIs" {
  description = "A list of the APIs that have been created and the API management services associated with them"
  type = list(object(
    {
      name                = string
      ResourceGroupName   = string
      api_management_name = string
      protocols           = list(string)
      Path                = string
      display_name        = string
      revision            = number
    }
  ))
}

variable "Env" {
  description = "The environment of the build"
  type        = string

}

