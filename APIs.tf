variable "APIs" {
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

  default = [
    {
      name                = "vonGHFunctions"
      ResourceGroupName   = "GHFunctions"
      api_management_name = "vonGHFunctions-apim"
      protocols           = ["https"]
      Path                = "api"
      display_name        = "vonGHFunctions"
      revision            = 1
    }
  ]
}

