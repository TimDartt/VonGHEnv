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
  default = [{
    nicname                       = "gh-df-private-nic"
    resource_group_name           = "gh-networking"
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    ip_configuration = [
      {
        name                          = "internal"
        subnet_id_name                = "gh-internal-1"
        private_ip_address_allocation = "Dynamic"
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
