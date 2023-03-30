variable "APIManagers" {
  type = list(object(
    {
      Name                    = string
      ResourceGroup           = string
      Sku                     = string
      EnableClientCertificate = bool
    }
  ))
  default = [{
    Name                    = "vonGHFunctions-apim-stg"
    ResourceGroup           = "ghfunctions"
    Sku                     = "Consumption_0"
    EnableClientCertificate = false
  }]

}
