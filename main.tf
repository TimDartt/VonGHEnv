# Create The Networking resource group

# Define and build the Resource Groups
# by prebuilding the resources and groups we can reference them later in the process without having to build them as an initial step
module "resourceGroup" {
  source            = "./modules/ResourceGroups"
  for_each          = { for index, item in var.ResourceGroups : index => item }
  ResourceGroupName = each.value.resource_group_name
  ResourceLocation  = each.value.location
}


#define the network resource... 
module "Network_Building" {
  source         = "./modules/Network"
  subNet         = "1"                                      # not currently in use
  security_rules = concat(var.SQLSecRules, var.IISSecRules) #these are loose at best. We still need to setup ASG's
  secGroupName   = "GlobalHealthNSGSecurity"                #this will eventually need to be modified to reflect the subnet/environment
  resourceGroup  = azurerm_resource_group.vonGlobalHealhRG.name
  networkName    = "GlobalHealthNet"
}




# resource "azurerm_resource_group" "vonGlobalHealhRG" {
#   name     = "vonGHresourceGroup"
#   location = "eastus"
# }



# #create a sql Database :)
# module "envSqlDatabase" {
#   source       = "./modules/SqlServers"
#   resoureGroup = azurerm_resource_group.vonGlobalHealhRG.name
#   location     = azurerm_resource_group.vonGlobalHealhRG.location
#   sqlName      = "globalhealth-sql${var.instance}" # note: We currently have this name in the existing Bonfire env. Names must be unique in azure (all of azure)
#   sqlLogin     = "tdarttAdmin"
#   sqlPassword  = "Squ!dD@ncer"
#   databases    = tolist(var.dbNames)
#   tags = {
#     "Owner"    = "VON"
#     "Creator"  = "Tim"
#     "instance" = "${var.instance}"
#   }
# }
