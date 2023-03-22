#testing approaches for output

# a complex object
output "NetworkSubNets" {
  #  value = { for subNet in azurerm_virtual_network.curvNnet.subnet : subNet.name => subnet.id }
  # value = azurerm_virtual_network.curvNnet.subnet
  value = {
    name = "subnets",
    instances = {
      for instance in azurerm_virtual_network.curvNnet.subnet :
      instance.name => {
        id = instance.id
      }
    },
  }
}

# a key value pair set
output "NetworkSubNetsKV" {
  #  value = { for subNet in azurerm_virtual_network.curvNnet.subnet : subNet.name => subnet.id }
  # value = azurerm_virtual_network.curvNnet.subnet
  value = {
    for k, v in azurerm_virtual_network.curvNnet.subnet : k.name => { id = v.id, name = v.name }
  }
}

