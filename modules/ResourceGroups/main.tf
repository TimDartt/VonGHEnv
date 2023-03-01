# resource "azurerm_resource_group" "defaultGroup" {
#   name     = (var.ResourceGroupName)
#   location = (var.ResourceLocation)
# }

# this module creates a resource group based on the passed information
resource "azurerm_resource_group" "baseRG" {
  name     = var.ResourceGroupName
  location = var.ResourceLocation
  tags     = var.tags
}
