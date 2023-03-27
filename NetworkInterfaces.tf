variable "NetworkInterface" {
  type = list(object(
    {
      nicname                       = string
      resource_group_name           = string
      enable_accelerated_networking = bool
      enable_ip_forwarding          = bool
      ip_configuration = list(object({
        name                          = string
        subnet_id_name                = string
        private_ip_address_allocation = string
      }))
    }
  ))
  default = [
    {
      nicname                       = "gh-df-private-nic"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = FALSE
      enable_ip_forwarding          = FALSE
      ip_configuration = [
        {


          name = "privateEndpointIpConfig.2fae0a38-7e70-44f6-b4ef-570752d741eb"
          subnet_id_name : "core-routing",
          private_Ip_address_allocation : "Dynamic",

        }
      ]
    },
    {
      nicname                       = "gh-scaffold-api-private.nic.77c1e40a-d1ac-4979-a106-39111e98ce46"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = FALSE
      enable_ip_forwarding          = FALSE
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.17fee07e-ac77-430d-aeaf-0e4d8efd59f7"
          subnet_id_name : "gh-internal-1",
          private_Ip_address_allocation : "Dynamic",
        }
      ]
    },
    {

      nicname                       = "gh-scaffold-mssql-private-nic"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = FALSE
      enable_ip_forwarding          = FALSE
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.2fae0a38-7e70-44f6-b4ef-570752d741eb"
          subnet_id_name : "gh-internal-1",
          private_Ip_address_allocation : "Dynamic",

        }
      ]
    },
    {
      nicname                       = "gh-scaffold-sql-storage-private-nic"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = FALSE
      enable_ip_forwarding          = FALSE
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.32efcc72-5fde-4f34-87bc-7488cfdb5efe"
          subnet_id_name : "gh-internal-1",
          private_Ip_address_allocation : "Dynamic",

          name = ""
          subnet_id_name : "",
          private_Ip_address_allocation : "Dynamic",

        }
      ]
    },
    {

      nicname                       = "gh-fhir-private-nic"
      resource_group_name           = "gh-scaffold-fhir"
      enable_accelerated_networking = FALSE
      enable_ip_forwarding          = FALSE
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.af76fd56-1a0f-4b3b-8b38-a0f02c7638af"
          subnet_id_name : "gh-internal-1",
          private_Ip_address_allocation : "Dynamic",

        }
      ]
  }]
}

/*
  enable_accelerated_networking = false
  enable_ip_forwarding = false
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }


*/
