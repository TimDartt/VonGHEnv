# set as a module so we can loop through a set of resource groups to create....
# this module creates a resource group based on the passed information
resource "azurerm_resource_group" "baseRg" {
  name     = var.ResourceGroupName
  location = var.ResourceLocation
  tags     = merge(var.tags, { created = timestamp() })
}
