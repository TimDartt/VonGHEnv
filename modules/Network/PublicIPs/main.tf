resource "azurerm_public_ip" "PublicIPResource" {
  location            = var.Location
  tags                = var.tags
  for_each            = { for index, item in var.PublicIPS : index => item }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
}


