variable "LocalNetworkGateways" {
  description = "A list of all the predefined network gateways"
  type = list(object(
    {
      name                = string
      resource_group_name = string
      gateway_address     = string
      address_space       = list(string)
    }
  ))
  default = [{
    address_space       = ["10.0.40.0/24", "192.168.100.0/24", "192.168.254.0/24", "192.168.255.0/24"] # list of addresses to allow
    gateway_address     = "66.211.134.66"                                                              # address of the gateway to connect to (in this case = fortigate)
    name                = "gh-scaffold-vnet-remote-network-taget-configuration"
    resource_group_name = "gh-networking"
  }]
}
