resource "azurerm_resource_group" "defaultGroup" {
  name     = (var.ResourceGroupName)
  location = (var.ResourceLocation)
}
