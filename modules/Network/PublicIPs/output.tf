# a key value pair set
output "PublicIPs" {
  #  value = { for subNet in azurerm_virtual_network.curvNnet.subnet : subNet.name => subnet.id }
  # value = azurerm_virtual_network.curvNnet.subnet
  # value = azurerm_public_ip.PublicIPResource
  # {
  #   for k, v in azurerm_public_ip : k.name => { name = v.name, ipaddress = v.ip_address }
  # }
  # #

  value = {
    name = "PublicIPAddresses",
    instances = {
      for instance in azurerm_public_ip.PublicIPResource :
      instance.name => {
        ip = instance.ip_address
      }
    },
  }

}
