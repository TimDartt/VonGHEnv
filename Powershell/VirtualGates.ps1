# Get-AzVirtualNetworkGateway

### Boiler Plate
# get all the storage account info
# 
# first connect to azure
Connect-AzAccount
clear

#next get all the 
Get-AzContext #-ListAvailable

$outputfinal=@()   # create the output string
foreach ($Subscription in $(Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}) )    # get all the subscriptions
    {
        $outputtemp = ""
        # get the subscription
        if ($Subscription.SubscriptionId -eq '71753224-e8e9-4591-a74c-9ba9f5767223')  # the scaffolding Sub ID
        {
            Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
            ####    replace the next command with the appropriate azure fetchs
            $vgates =Get-AzVirtualNetworkGateway  -ResourceGroupName "gh-networking"
            foreach ($vg in $vgates)
                {
                         Write-Output $vg -- use to see the output 
                        #### The following is used to create the output 
                        #            $outputtemp += "{`nname                    = '"+$sa.StorageAccountName + "'"
                        #            $outputtemp += "`nresource_group_name      = '"+$sa.ResourceGroupName+ "'"
                        #            $outputtemp += "`naccount_tier             = 'Standard'"
                        #            $outputtemp += "`naccount_replication_type = 'RAGRS'"
                        #            $outputtemp += "`naccount_kind             = '"+$sa.Kind+ "'"
                        #            $outputtemp += "`n}`n,"
                }
        }
        Write-Output $outputtemp
        #####   
    }

<#
resource "azurerm_virtual_network_gateway" "example" {
  name                = "test"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.example.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.example.id
  }

  vpn_client_configuration {
    address_space = ["10.2.0.0/24"]

    root_certificate {
      name = "DigiCert-Federated-ID-Root-CA"

      public_cert_data = <<EOF
#>