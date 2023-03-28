variable "NetworkInterface" {
  description = "A list of all the defined network interfaces and their IP configurations"
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
        primary                       = bool
      }))
    }
  ))
  default = [
    {
      nicname                       = "gh-df-private-nic"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.2fae0a38-7e70-44f6-b4ef-570752d741eb"
          subnet_id_name : "core-routing",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {
      nicname                       = "gh-scaffold-api-private.nic.77c1e40a-d1ac-4979-a106-39111e98ce46"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.17fee07e-ac77-430d-aeaf-0e4d8efd59f7"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {

      nicname                       = "gh-scaffold-mssql-private-nic"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.2fae0a38-7e70-44f6-b4ef-570752d741eb"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {
      nicname                       = "gh-scaffold-sql-storage-private-nic"
      resource_group_name           = "gh-networking"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.32efcc72-5fde-4f34-87bc-7488cfdb5efe"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {
      nicname                       = "gh-fhir-private-nic"
      resource_group_name           = "gh-scaffold-fhir"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.af76fd56-1a0f-4b3b-8b38-a0f02c7638af"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {
      nicname                       = "gh-scaff-loadbalancer-private-linkservice.nic"
      resource_group_name           = "gh-scaffold-loadbalancer"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.eab5d09b-2fe5-42c4-aea5-5a1d1be329b6"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        },
        {

          name = "privateEndpointIpConfig.0693cb79-2b73-4043-9228-22d4a5eedefe"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = false
        }
      ]
    },
    {
      nicname                       = "gh-scaff-loadbalancer-virtualfordward-one901_z1"
      resource_group_name           = "gh-scaffold-loadbalancer"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "gh-scaffold-lb-priv-private-linkservice-1"
          subnet_id_name : "gh-scaffold-lb-priv-private-linkservice",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {

      nicname                       = "gh-scaffold-privendpoint-storage-nic"
      resource_group_name           = "gh-scaffold-storage"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "ipconfig1"
          subnet_id_name : "gh-scaffold-lb-priv-backendservers",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {

      nicname                       = "gh-scaffold-queue-private-nic"
      resource_group_name           = "gh-scaffold-storage"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {

          name = "privateEndpointIpConfig.60738fe2-68d6-4470-8623-9ccf3b18090c"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {

      nicname                       = "gh-scaffold-sql-storage-private-nic"
      resource_group_name           = "gh-scaffold-storage"
      enable_accelerated_networking = true
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.237a0d07-2138-4164-8403-68b5d92fd5ee"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    },
    {
      nicname                       = "gh-ssms706_z1"
      resource_group_name           = "gh-scaffold-workstations"
      enable_accelerated_networking = false
      enable_ip_forwarding          = false
      ip_configuration = [
        {
          name = "privateEndpointIpConfig.1ec4c945-b183-438d-8a5c-aec9d6fd4fdd"
          subnet_id_name : "gh-internal-1",
          private_ip_address_allocation : "Dynamic",
          primary = true
        }
      ]
    }

  ]
  #   {
  #   nicname                       = "gh-df-private-nic"
  #   resource_group_name           = "gh-networking"
  #   enable_accelerated_networking = false
  #   enable_ip_forwarding          = false
  #   ip_configuration = [
  #     {
  #       name                          = "internal"
  #       subnet_id_name                = "gh-internal-1"
  #       private_ip_address_allocation = "Dynamic"
  #     }
  #   ]
  # }

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
