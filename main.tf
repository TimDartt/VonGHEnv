# first - Define the Resource Group
resource "azurerm_resource_group" "vonGlobalHealhRG" {
  name     = "vonGHresourceGroup"
  location = "eastus"
}

# and now we create the vNet that we will be putting these into along with the rules we wish to apply!
module "GlobalGHNet" {
  source         = "./modules/Network"
  subNet         = "1"                                      # not currently in use
  security_rules = concat(var.SQLSecRules, var.IISSecRules) #these are loose at best. We still need to setup ASG's
  secGroupName   = "GlobalHealthNSGSecurity"                #this will eventually need to be modified to reflect the subnet/environment
  resourceGroup  = azurerm_resource_group.vonGlobalHealhRG.name
  networkName    = "GlobalHealthNet"
}


#create a sql Database :)
module "envSqlDatabase" {
  source       = "./modules/SqlServers"
  resoureGroup = azurerm_resource_group.vonGlobalHealhRG.name
  location     = azurerm_resource_group.vonGlobalHealhRG.location
  sqlName      = "globalhealthsql"
  sqlLogin     = "tdarttAdmin"
  sqlPassword  = "Squ!dD@ncer"
  databases    = tolist(var.dbNames)
  tags = {
    "Owner"       = "VON"
    "Creator"     = "Tim"
    "Environment" = var.environment
    "instance"    = "${var.instance}"
  }
}
