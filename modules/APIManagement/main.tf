
resource "azurerm_api_management" "example" {
  publisher_name  = var.Company
  publisher_email = var.ContactEmail
  location        = var.Location
  # loop through the managers and create each
  for_each                   = { for index, item in var.APIManagers : index => item }
  name                       = each.value.Name
  resource_group_name        = each.value.ResourceGroup
  sku_name                   = each.value.Sku
  client_certificate_enabled = each.value.EnableClientCertificate
}
