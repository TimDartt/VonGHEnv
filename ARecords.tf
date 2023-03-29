variable "ARecords" {
  description = "A list of the A records"
  type = list(object(
    {
      name                = string
      zone_name           = string
      resource_group_name = string
      ttl                 = number
      records             = list(string)

    }
  ))
  default = [
    {
      name                = "vonghfunctions.scm"
      zone_name           = "privatelink.azurewebsites.net"
      resource_group_name = "gh-networking"
      ttl                 = 10
      records             = ["10.150.80.10"]
    },
    {
      name                = "vonghfunctions"
      zone_name           = "privatelink.azurewebsites.net"
      resource_group_name = "gh-networking"
      ttl                 = 10
      records             = ["10.150.80.10"]
    },
    {
      name                = "ghscaffolddfstorage"
      zone_name           = "privatelink.blob.core.windows.net"
      resource_group_name = "gh-networking"
      ttl                 = 10
      records             = ["10.150.80.8"]
    },
    {
      name                = "sqlvazjy37v2w3yqcs"
      zone_name           = "privatelink.blob.core.windows.net"
      resource_group_name = "gh-networking"
      ttl                 = 10
      records             = ["10.150.80.11"]
    },
    {
      name                = "veeamstoragetrials"
      zone_name           = "privatelink.blob.core.windows.net"
      resource_group_name = "gh-networking"
      ttl                 = 3600
      records             = ["10.150.50.4"]
    },
    {
      name                = "ghscaffolddfstorage"
      zone_name           = "privatelink.queue.core.windows.net"
      resource_group_name = "gh-networking"
      ttl                 = 10
      records             = ["10.150.80.9"]
    },
    {
      name                = "sqlvazjy37v2w3yqcs"
      zone_name           = "privatelink.web.core.windows.net"
      resource_group_name = "gh-networking"
      ttl                 = 10
      records             = ["10.150.80.12"]
    },
    {
      name                = "db8c0"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.4"]
    },
    {
      name                = "db8c1"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.5"]
    },
    {
      name                = "db8c2"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.6"]
    },
    {
      name                = "gh-scaff-loadbalancer-virtualfordward-one"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.10.4"]
    },
    {
      name                = "gh-ssms"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.95.4"]
    },
    {
      name                = "ghscaffoldhealthdata-workspace"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 3600
      records             = ["10.150.80.4"]
    },
    {
      name                = "gsa-08295a57-fd5a000000"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.90.5"]
    },
    {
      name                = "gsa-08295a57-fd5a000003"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.90.8"]
    },
    {
      name                = "vpngw000000"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.0.4"]
    },
    {
      name                = "vpngw000001"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.0.5"]
    },
    {
      name                = "wf2c0"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.7"]
    },
    {
      name                = "wf2c1"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.8"]
    },
    {
      name                = "wf2c2"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.9"]
    },
    {
      name                = "wf2c3"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.10"]
    },
    {
      name                = "wf2c4"
      zone_name           = "azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.70.11"]
    },
    {
      name                = "ghscaffoldhealthdata-gh-scaffold-fhir"
      zone_name           = "fhir.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 3600
      records             = ["10.150.80.5"]
    },
    {
      name                = "vonfhirpoc-vonpoc"
      zone_name           = "fhir.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 3600
      records             = ["20.62.134.243"]
    },
    {
      name                = "ghscaffoldhealthdata-gh-scaffold-fhir.fhir"
      zone_name           = "privatelink.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.80.5"]
    },
    {
      name                = "ghscaffoldhealthdata-workspace"
      zone_name           = "privatelink.azurehealthcareapis.com"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.80.4"]
    },
    {
      name                = "gh-scaffold-mssql"
      zone_name           = "privatelink.d38245b121dc.database.windows.net"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.80.7"]
    },
    {
      name                = "vonghdatafactory.eastus"
      zone_name           = "privatelink.datafactory.azure.net"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 10
      records             = ["10.150.80.6"]
    },
    {
      name                = "mobileservice"
      zone_name           = "stg.vtoxford.org"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 3600
      records             = ["10.0.40.42"]
    },
    {
      name                = "sprockets"
      zone_name           = "stg.vtoxford.org"
      resource_group_name = "gh-scaffold-dns"
      ttl                 = 3600
      records             = ["10.0.40.42"]
    }
  ]

}
