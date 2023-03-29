variable "SOARecords" {
  description = "A list of the SOARecords for the env"
  type = list(object(
    {
      zone_name           = string
      resource_group_name = string
    }
  ))

  default = [
    {
      zone_name           = "privatelink.azurewebsites.net"
      resource_group_name = "gh-networking"
    },
    {
      zone_name           = "privatelink.blob.core.windows.net"
      resource_group_name = "gh-networking"
    },
    {
      zone_name           = "privatelink.database.windows.net"
      resource_group_name = "gh-networking"
    },
    {
      zone_name           = "privatelink.queue.core.windows.net"
      resource_group_name = "gh-networking"
    },
    {
      zone_name           = "privatelink.web.core.windows.net"
      resource_group_name = "gh-networking"
    },
    {
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    },
    {
      zone_name           = "fhir.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    },
    {
      zone_name           = "privatelink.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    },
    {
      zone_name           = "privatelink.d38245b121dc.database.windows.net"
      resource_group_name = "gh-scaffold-dns"
    },
    {
      zone_name           = "privatelink.datafactory.azure.net"
      resource_group_name = "gh-scaffold-dns"
    },
    {
      zone_name           = "privatelink.dicom.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    },
    {
      zone_name           = "scaffold.vtoxford.org"
      resource_group_name = "gh-scaffold-dns"
    },
    {
      zone_name           = "stg.vtoxford.org"
      resource_group_name = "gh-scaffold-dns"
    },
  ]
}
