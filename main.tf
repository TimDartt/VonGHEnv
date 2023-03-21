# Create The Networking resource group


# Define and build the Resource Groups
# by prebuilding the resources and groups we can reference them later in the process without having to build them as an initial step
module "resourceGroup" {
  source            = "./modules/ResourceGroups"
  for_each          = { for index, item in var.ResourceGroups : index => item }
  ResourceGroupName = each.value.resource_group_name
  ResourceLocation  = each.value.location
  tags              = each.value.tags
}


# lets try a straight network build first .... Worked
# Try the Module Build next
# resource "azurerm_virtual_network" "curvNnet" {
#   name                = "scaffold-core"
#   location            = "EastUs"
#   resource_group_name = "gh-networking" # the gh-Networking RG was created in the resource group set - Checked - works
#   address_space       = ["${var.BaseNet}0.0/16"]
# #  SubNets             = locals.Scaffold-Core-SubNets
#   #Depends on checks to see if the module has been run and completed before continuing 
#   depends_on = [
#     module.resourceGroup
#   ]
# }

#Network Module Build -- Worked
# adding subnet builds -- Worked
# adding Security Build
module "Network_Building" {
  source        = "./modules/Network/vNets"
  resourceGroup = "gh-networking"
  networkName   = "scaffold-core"
  location      = "eastus"
  AddressSpace  = "0.0/16"
  BaseNet       = var.BaseNet
  tags          = local.tags
  SubNets       = local.Scaffold-Core-SubNets
  #Depends on checks to see if the module has been run and completed before continuing 
  depends_on = [
    module.resourceGroup
  ]
  # security_rules = concat(var.SQLSecRules, var.IISSecRules) #these are loose at best. We still need to setup ASG's
  # secGroupName   = "GlobalHealthNSGSecurity"                #this will eventually need to be modified to reflect the subnet/environment
}

# Build Network Security Groups - Works as a straight call
# Move to a Module
module "MsSqlNSG" {
  source            = "./modules/Network/NSG"
  NSGName           = "nsg-gh-scaffold-mssql"
  Location          = "eastus"
  ResourceGroupName = "gh-networking"
  security_rules    = local.nsg-gh-scaffold-mssql-Rules
  depends_on = [
    module.resourceGroup
  ]
}



# Build RGS works
# Build Straight Network Works


# # #define the first network resource... 
# # #first the resource group to contain the networking elements
# # ** Testing Depends_on
# resource "azurerm_resource_group" "gh-networking" {
#   name     = "gh-networking"
#   location = local.location
#   tags     = local.tags
# }
# # build any needed vNets
# module "vNets" {
#   source        = "./modules/Network/vNets"
#   networkName   = "scaffold-core"
#   location      = "eastus"
#   tags          = local.tags
#   BaseNet       = var.BaseNet
#   SubNets       = local.Scaffold-Core-SubNets # the list of Subnets to create for the vNet
#   resourceGroup = "gh-networking"


#   security_rules = concat(var.SQLSecRules, var.IISSecRules) #these are loose at best. We still need to setup ASG's
#   //security_rules = var.nsg-gh-scaffold-mssql-Rules
#   secGroupName = "GlobalHealthNSGSecurity" #this will eventually need to be modified to reflect the subnet/environment

#   depends_on = [
#     module.resourceGroup
#   ]
# }

# # module "Network_Building" {
# #   source         = "./modules/Network"
# #   subNet         = "1"                                      # not currently in use
# #   security_rules = concat(var.SQLSecRules, var.IISSecRules) #these are loose at best. We still need to setup ASG's
# #   secGroupName   = "GlobalHealthNSGSecurity"                #this will eventually need to be modified to reflect the subnet/environment
# #   resourceGroup  = azurerm_resource_group.gh-networking.name
# #   networkName    = "scaffold-core"
# # }




# # resource "azurerm_resource_group" "vonGlobalHealhRG" {
# #   name     = "vonGHresourceGroup"
# #   location = "eastus"
# # }



# # #create a sql Database :)
# # module "envSqlDatabase" {
# #   source       = "./modules/SqlServers"
# #   resoureGroup = azurerm_resource_group.vonGlobalHealhRG.name
# #   location     = azurerm_resource_group.vonGlobalHealhRG.location
# #   sqlName      = "globalhealth-sql${var.instance}" # note: We currently have this name in the existing Bonfire env. Names must be unique in azure (all of azure)
# #   sqlLogin     = "tdarttAdmin"
# #   sqlPassword  = "Squ!dD@ncer"
# #   databases    = tolist(var.dbNames)
# #   tags = {
# #     "Owner"    = "VON"
# #     "Creator"  = "Tim"
# #     "instance" = "${var.instance}"
# #   }
# # }
