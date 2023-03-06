output "secID" {
  value = azurerm_network_security_group.envSecGroup.id
}
output "testEnvVariables" {
  value = "BaseNet = ${var.BaseNet}"
}
