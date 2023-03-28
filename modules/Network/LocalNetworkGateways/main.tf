resource "azurerm_local_network_gateway" "localNetGateway" {
  name                = var.GatewayName
  resource_group_name = var.ResourceGroup
  location            = var.Location
  gateway_address     = var.GatewayAddress
  address_space       = var.AddressSpace
}
