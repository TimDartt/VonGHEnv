# define the FHIR workspace
resource "azurerm_healthcare_workspace" "ghWorkSpace" {
  name                = "ghWorkSpace"
  location            = var.location
  resource_group_name = var.resoureGroup
}


#define the VonFhirService :)
resource "azurerm_healthcare_fhir_service" "vonfhirservice" {
  name                = "vonfhirservice"
  location            = var.location
  resource_group_name = var.resoureGroup
  workspace_id        = azurerm_healthcare_workspace.ghWorkSpace.id
  kind                = "fhir-R4"

  authentication {
    authority = "https://login.microsoftonline.com/c279104c-21c6-44e2-ae24-2bd692087c84"
    audience  = "https://vonfhirservice.azurehealthcareapis.com"
  }

  identity {
    type = "SystemAssigned"
  }

  container_registry_login_server_url = ["tfex-container_registry_login_server"]

  # we should define these: Not defined in the bonfire version
  #   cors {
  #     allowed_origins     = ["https://tfex.com:123", "https://tfex1.com:3389"]
  #     allowed_headers     = ["*"]
  #     allowed_methods     = ["GET", "DELETE", "PUT"]
  #     max_age_in_seconds  = 3600
  #     credentials_allowed = true
  #   }
  configuration_export_storage_account_name = "storage_account_name"

}
