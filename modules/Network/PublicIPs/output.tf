# a key value pair set
output "PublicIPs" {
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
