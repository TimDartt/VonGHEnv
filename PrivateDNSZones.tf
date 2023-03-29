variable "PrivateDNSZones" {
  description = "All the private DNS Zones to create"
  type = list(object(
    {
      name                = string
      resource_group_name = string
    }
  ))
  default = [

    {
      name                = "privatelink.azurewebsites.net"
      resource_group_name = "gh-networking"
    }
    , {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "gh-networking"
    }
    , {
      name                = "privatelink.database.windows.net"
      resource_group_name = "gh-networking"
    }
    , {
      name                = "privatelink.queue.core.windows.net"
      resource_group_name = "gh-networking"
    }
    , {
      name                = "privatelink.web.core.windows.net"
      resource_group_name = "gh-networking"
    }
    , {
      name                = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    }
    , {
      name                = "fhir.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    }
    , {
      name                = "privatelink.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    }
    , {
      name                = "privatelink.d38245b121dc.database.windows.net"
      resource_group_name = "gh-scaffold-dns"
    }
    , {
      name                = "privatelink.datafactory.azure.net"
      resource_group_name = "gh-scaffold-dns"
    }
    , {
      name                = "privatelink.dicom.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
    }
    , {
      name                = "scaffold.vtoxford.org"
      resource_group_name = "gh-scaffold-dns"
    }
    , {
      name                = "stg.vtoxford.org"
      resource_group_name = "gh-scaffold-dns"
    }
  ]
}
