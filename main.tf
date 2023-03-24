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

#Network Module Build -- Worked
# adding subnet builds -- Worked
# adding Security Build
module "Network_Building" {
  source        = "./modules/Network/vNets"
  resourceGroup = "gh-networking"
  networkName   = "scaffold-core"
  location      = var.location
  AddressSpace  = "0.0/16"
  BaseNet       = var.BaseNet
  tags          = local.tags
  SubNets       = var.Scaffold-Core-SubNets
  #Depends on checks to see if the module has been run and completed before continuing 
  depends_on = [
    module.resourceGroup
  ]
  # security_rules = concat(var.SQLSecRules, var.IISSecRules) #these are loose at best. We still need to setup ASG's
  # secGroupName   = "GlobalHealthNSGSecurity"                #this will eventually need to be modified to reflect the subnet/environment
}


#### REGION NSG Builds 
# Build Network Security Groups - Works as a straight call
# Move to a Module - Worked 
# To use: We need to create a set of rules to apply, pass in with a Resource group that has been build afterwards, we need to create the link between the network and the security
# due to complexity and time factors we are going to build Each NSG/ASG this way.
# doing this allows us to reuse and combine rule sets
# TODO: come back and figure out how to loop these as a list pass in the root main.tf
module "NSG-Sql" {
  source            = "./modules/Network/NSG"
  NSGName           = "nsg-gh-scaffold-mssql"
  Location          = var.location
  ResourceGroupName = "gh-networking"
  security_rules    = var.nsg-gh-scaffold-mssql-Rules
  depends_on = [
    module.resourceGroup
  ]
}

module "NSG-SSMS" {
  source            = "./modules/Network/NSG"
  NSGName           = "gh-ssms-nsg"
  Location          = var.location
  ResourceGroupName = "gh-scaffold-workstations"
  security_rules    = var.gh-ssms-nsg
  depends_on = [
    module.resourceGroup
  ]
}


module "NSG-LoadBalancer" {
  source            = "./modules/Network/NSG"
  NSGName           = "gh-scaff-loadbalancer-instanceone-nsg"
  Location          = var.location
  ResourceGroupName = "gh-scaffold-loadbalancer"
  security_rules    = var.gh-scaff-loadbalancer-instanceone-nsg
  depends_on = [
    module.resourceGroup
  ]
}

module "NSG-Monitor" {
  source            = "./modules/Network/NSG"
  NSGName           = "von-gh-scaffold-monitor-nsg"
  Location          = var.location
  ResourceGroupName = "gh-scaffold-workstations"
  security_rules    = var.von-gh-scaffold-monitor-nsg
  depends_on = [
    module.resourceGroup
  ]
}

#Now to associate the NSG with the appropriate resources
# the sql nsg is applied to a subnet  but no nics
resource "azurerm_subnet_network_security_group_association" "NSGAssociationSql" {
  subnet_id                 = module.Network_Building.NetworkSubNetsKV["gh-private-1"].id # the vNet Module builds and passed back an object list containing each of the subnets
  network_security_group_id = module.NSG-Sql.NsgId                                        # this is the output of the NSG module
  depends_on = [
    module.resourceGroup,
    module.NSG-Sql
  ]
}

#TODO: gh-ssms-nsg is associated with a Network interface - return and fix after its modeled.
#TODO: von-gh-scaffold-monitor-nsg doesn't seem to be associated with anything?
#TODO: gh-scaff-loadbalancer-instanceone-nsg doesn't seem to be associated with anything?


#### END REGION NSG Builds 

#Lets build the Managed instance Sql Database
#create a sql Database :)
module "envSqlDatabase" {
  source       = "./modules/SqlServers"
  resoureGroup = "gh-scaffolding-database"
  location     = var.location
  sqlName      = "gh-scaffold-mssql-${var.Env}" # note: We currently have this name in the existing Bonfire env. Names must be unique in azure (all of azure)
  sqlLogin     = var.sqlLogin                   # "tdarttAdmin"
  sqlPassword  = var.sqlPassword                # "Squ!dD@ncer"
  databases    = tolist(var.dbNames)            # List of Database to create
  tags = merge({
    "Owner"   = "VON"
    "Creator" = "Tim"
  }, local.tags)
  depends_on = [
    module.resourceGroup
  ]
}

# build the set of azure application Security groups - they are actually quite simple...
module "ASGcreation" {
  source    = "./modules/ApplicationSecurityGroups"
  ASGGroups = var.ASGGroups
  location  = var.location
}





# # create the api management service
# # since we will only need one.... don't make a module yet
# resource "azurerm_api_management" "rApiManagement" {
#   name                = "vonGHFunctions-apim"
#   location            = var.location
#   resource_group_name = "ghFunctions"
#   publisher_name      = "Vermont Oxford Networks"
#   publisher_email     = "company@terraform.io"

#   sku_name = "Developer_1"
# }




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

