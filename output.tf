## all outputs from the main module should be listed here

# Display the base net as a test
output "testEnvVariables" {
  value = "BaseNet = ${var.BaseNet}"
}

#list all the created public IP address....
output "PublicIps" {
  value = module.PublicIPsResource.PublicIPs
}
