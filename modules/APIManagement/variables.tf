variable "APIMangers" {
  descrdescription = "List of APIManagers"
  type = list(object(
    {
      Name                    = string
      ResourceGroup           = string
      Sku                     = string
      EnableClientCertificate = bool
    }
  ))
}
variable "Location" {
  description = "Where to create the resource"
  type        = string
}

variable "ContactEmail" {
  description = "Contact email for this subscription"
  type        = string
}

variable "Company" {
  description = "Name of the company to display"
  type        = string
}
