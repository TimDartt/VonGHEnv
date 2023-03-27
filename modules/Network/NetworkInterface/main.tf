
resource "azurerm_network_interface" "nicComp" {
  name                          = var.nicname
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enable_accelerated_networking = var.enable_accelerated_networking
  enable_ip_forwarding          = var.enable_ip_forwarding
  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = var.SubNets[ip_configuration.value.subnet_id_name].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      primary                       = ip_configuration.value.primary
    }
  }
}
