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

# build the set of azure application Security groups - they are actually quite simple...
module "ASGcreation" {
  source    = "./modules/ApplicationSecurityGroups"
  ASGGroups = var.ASGGroups
  location  = var.location
}

######## Region - Build network interface components :)   ########

#Network Module Build 
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

module "network_interface" {
  source   = "./modules/Network/NetworkInterface"
  location = var.location
  #subnets             = module.Network_Building.NetworkSubNetsKV
  for_each                      = { for index, item in var.NetworkInterface : index => item }
  nicname                       = each.value.nicname
  resource_group_name           = each.value.resource_group_name
  enable_accelerated_networking = each.value.enable_accelerated_networking
  enable_ip_forwarding          = each.value.enable_ip_forwarding
  ip_configuration              = each.value.ip_configuration
  SubNets                       = module.Network_Building.NetworkSubNetsKV
  depends_on = [
    module.Network_Building
  ]
}

module "Local_Gateway" {
  # loop through all the defined gateways and build them. NOTE: append the intial BaseNet
  source         = "./modules/Network/LocalNetworkGateways"
  Location       = var.location
  for_each       = { for index, item in var.LocalNetworkGateways : index => item }
  GatewayName    = each.value.name
  ResourceGroup  = each.value.resource_group_name
  GatewayAddress = each.value.gateway_address
  AddressSpace   = each.value.address_space
}

#### set up the dns entries
module "PrivateDNSZones" {
  source          = "./modules/Network/DNS/PrivateDNSZones"
  PrivateDNSZones = var.PrivateDNSZones
  depends_on = [
    module.resourceGroup
  ]
}

module "ARecords" {
  source   = "./modules/Network/DNS/ARecords"
  ARecords = var.ARecords
  depends_on = [
    module.PrivateDNSZones
  ]

}
######## End Region - Build network interface components :)   ########


#### Build the Storage accounts (which are used later on!)
module "StorageAccount" {
  source          = "./modules/StorageAccounts"
  StorageAccounts = var.StorageAccounts
  Location        = var.location
  Tags            = local.tags
}



#### REGION NSG Builds 
# Build Network Security Groups - Works as a straight call
# Move to a Module - Worked 
# To use: We need to create a set of rules to apply, pass in with a Resource group that has been build afterwards, we need to create the link between the network and the security
# due to complexity and time factors we are going to build Each NSG/ASG this way.
# doing this allows us to reuse and combine rule sets
# TODO: come back and figure out how to loop these as a list pass in the root main.tf
module "NSGSql" {
  source            = "./modules/Network/NSG"
  NSGName           = "nsg-gh-scaffold-mssql"
  Location          = var.location
  ResourceGroupName = "gh-networking"
  security_rules    = var.nsg-gh-scaffold-mssql-Rules
  depends_on = [
    module.resourceGroup
  ]
}

module "NSGSSMS" {
  source            = "./modules/Network/NSG"
  NSGName           = "gh-ssms-nsg"
  Location          = var.location
  ResourceGroupName = "gh-scaffold-workstations"
  security_rules    = var.gh-ssms-nsg
  depends_on = [
    module.resourceGroup
  ]
}

module "NSGLoadBalancer" {
  source            = "./modules/Network/NSG"
  NSGName           = "gh-scaff-loadbalancer-instanceone-nsg"
  Location          = var.location
  ResourceGroupName = "gh-scaffold-loadbalancer"
  security_rules    = var.gh-scaff-loadbalancer-instanceone-nsg
  depends_on = [
    module.resourceGroup
  ]
}

module "NSGMonitor" {
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
  network_security_group_id = module.NSGSql.NsgId                                         # this is the output of the NSG module
  depends_on = [
    module.resourceGroup,
    module.NSGSql
  ]
}

#TODO: gh-ssms-nsg is associated with a Network interface - return and fix after its modeled.
#TODO: von-gh-scaffold-monitor-nsg doesn't seem to be associated with anything?
#TODO: gh-scaff-loadbalancer-instanceone-nsg doesn't seem to be associated with anything?

# output "test" {
#   value = module.Network_Building.NetworkSubNetsKV["gh-private-1"]
# }

#### END REGION NSG Builds 

module "PublicIPsResource" {
  # this will output a set of Names/PublicIPS based on the PublicIPs defined in PublicIPs.tf
  source    = "./modules/Network/PublicIPs"
  PublicIPS = var.PublicIPS
  Location  = var.location
  tags      = local.tags
}

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

# Build out all the API Managers
module "APIManagers" {
  source       = "./modules/API/APIManagement"
  Location     = var.location
  ContactEmail = var.ContactEmail
  Company      = var.Company
  APIManagers  = var.APIManagers
  Env          = var.Env
  depends_on = [
    module.resourceGroup
  ]
}

module "APIs" {
  source = "./modules/API/APIs"
  APIs   = var.APIs
  Env    = var.Env
  depends_on = [
    module.APIManagers
  ]
}

#build all the service plans that are in use
module "ServicePlans" {
  source       = "./modules/API/ServicePlans"
  ServicePlans = var.ServicePlans
  Location     = var.location
}

module "FunctionApps" {
  source           = "./modules/API/FunctionApp"
  location         = var.location
  FunctionApps     = var.FunctionApps
  Env              = var.Env
  StorgeInfoRandom = module.StorageAccount.StorgeInfoRandom
  StorageAccounts  = module.StorageAccount.StorageAccountInfoKV
  ServicePlans     = module.ServicePlans.ServicePlanKV
}

# time to address private end points

# resource "azurerm_private_endpoint" "example" {
#   name                = "gh-df-private"
#   location            = var.location
#   resource_group_name = "gh-networking"
#   subnet_id           = module.Network_Building.NetworkSubNetsKV["gh-internal-1"] #azurerm_subnet.endpoint.id #scaffold-core/gh-internal-1

#   private_service_connection {
#     name                           = "example-privateserviceconnection"
#     private_connection_resource_id = azurerm_private_link_service.example.id
#     is_manual_connection           = false
#   }
# }


# resource "azurerm_private_endpoint_application_security_group_association" "example" {
#   private_endpoint_id           = azurerm_private_endpoint.example.id
#   application_security_group_id = azurerm_application_security_group.example.id
# }


# #build out the virtual Network Gateways
# resource "azurerm_virtual_network_gateway" "example" {
#   name                = "test"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   type     = "Vpn"
#   vpn_type = "RouteBased"

#   active_active = false
#   enable_bgp    = false
#   sku           = "Basic"

#   ip_configuration {
#     name                          = "vnetGatewayConfig"
#     public_ip_address_id          = azurerm_public_ip.example.id
#     private_ip_address_allocation = "Dynamic"
#     subnet_id                     = azurerm_subnet.example.id
#   }

#   # vpn_client_configuration {
#   #   address_space = ["10.2.0.0/24"]

#   #   root_certificate {
#   #     name = "DigiCert-Federated-ID-Root-CA"

# #       public_cert_data = <<EOF
# # MIIDuzCCAqOgAwIBAgIQCHTZWCM+IlfFIRXIvyKSrjANBgkqhkiG9w0BAQsFADBn
# # MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
# # d3cuZGlnaWNlcnQuY29tMSYwJAYDVQQDEx1EaWdpQ2VydCBGZWRlcmF0ZWQgSUQg
# # Um9vdCBDQTAeFw0xMzAxMTUxMjAwMDBaFw0zMzAxMTUxMjAwMDBaMGcxCzAJBgNV
# # BAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
# # Y2VydC5jb20xJjAkBgNVBAMTHURpZ2lDZXJ0IEZlZGVyYXRlZCBJRCBSb290IENB
# # MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvAEB4pcCqnNNOWE6Ur5j
# # QPUH+1y1F9KdHTRSza6k5iDlXq1kGS1qAkuKtw9JsiNRrjltmFnzMZRBbX8Tlfl8
# # zAhBmb6dDduDGED01kBsTkgywYPxXVTKec0WxYEEF0oMn4wSYNl0lt2eJAKHXjNf
# # GTwiibdP8CUR2ghSM2sUTI8Nt1Omfc4SMHhGhYD64uJMbX98THQ/4LMGuYegou+d
# # GTiahfHtjn7AboSEknwAMJHCh5RlYZZ6B1O4QbKJ+34Q0eKgnI3X6Vc9u0zf6DH8
# # Dk+4zQDYRRTqTnVO3VT8jzqDlCRuNtq6YvryOWN74/dq8LQhUnXHvFyrsdMaE1X2
# # DwIDAQABo2MwYTAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAdBgNV
# # HQ4EFgQUGRdkFnbGt1EWjKwbUne+5OaZvRYwHwYDVR0jBBgwFoAUGRdkFnbGt1EW
# # jKwbUne+5OaZvRYwDQYJKoZIhvcNAQELBQADggEBAHcqsHkrjpESqfuVTRiptJfP
# # 9JbdtWqRTmOf6uJi2c8YVqI6XlKXsD8C1dUUaaHKLUJzvKiazibVuBwMIT84AyqR
# # QELn3e0BtgEymEygMU569b01ZPxoFSnNXc7qDZBDef8WfqAV/sxkTi8L9BkmFYfL
# # uGLOhRJOFprPdoDIUBB+tmCl3oDcBy3vnUeOEioz8zAkprcb3GHwHAK+vHmmfgcn
# # WsfMLH4JCLa/tRYL+Rw/N3ybCkDp00s0WUZ+AoDywSl0Q/ZEnNY0MsFiw6LyIdbq
# # M/s/1JRtO3bDSzD9TazRVzn2oBqzSa8VgIo5C1nOnoAKJTlsClJKvIhnRlaLQqk=
# # EOF

#     #  }

#     # revoked_certificate {
#     #   name       = "Verizon-Global-Root-CA"
#     #   thumbprint = "912198EEF23DCAC40939312FEE97DD560BAE49B1"
#     # }
#  # }
# }


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


# ##### test the module outputs:
# # test the return of the random string
# output "StorgeInfoRandom" {
#   value = module.StorageAccount.StorgeInfoRandom
# }
# # review the base info as to what is being returned
# output "StorageInfo" {
#   value = module.StorageAccount.StorageInfo
# }
#check to see if we can access the data by name
# output "checkStorageInfo" {
#   #  value = module.StorageAccount.StorageInfo["ghfunction${module.StorageAccount.StorgeInfoRandom}"]
#   #value = module.StorageAccount.StorageAccountInfoKV["ghfunction${module.StorageAccount.StorgeInfoRandom}"].id
#   sensitive = true
#   #value     = module.StorageAccount.StorageAccountInfoKV["ghfunction${module.StorageAccount.StorgeInfoRandom}"].primary_access_key
# }
