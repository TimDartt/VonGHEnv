#Get-AzPrivateEndpoint
### Boiler Plate
# get all the storage account info
# 
# first connect to azure
Connect-AzAccount
clear

#next get all the 
Get-AzContext #-ListAvailable

$outputfinal=@()   # create the output string
foreach ( $Subscription in $(Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}) )    # get all the subscriptions
{
$outputtemp = ""
# get the subscription
    if ($Subscription.SubscriptionId -eq '71753224-e8e9-4591-a74c-9ba9f5767223')  # the scaffolding Sub ID
    {

        Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
####    replace the next command with the appropriate azure fetchs
        $PEs = Get-AzPrivateEndpoint
        foreach ($sa in $PEs)
        {
            # Write-Output $sa # use to see the output 
            #### The following is used to create the output
#            $pls = Get-AzPrivateLinkService -ResourceGroupName $sa.ResourceGroupName -Name $sa.Name
 #           Write-Output $pls -- use to see the output 

 # custom_network_interface_name
            # Get the substring between the last slash and search string
            $lastSlash = $sa.SubnetText.LastIndexOf("/")
            $subNet = $sa.SubnetText.Substring($lastSlash + 1, $sa.SubnetText.IndexOf(",") - $lastSlash - 2)

            $outputtemp += "{"
            $outputtemp += "`nname                = `""+$sa.Name + "`""
            $outputtemp += "`ncustom_network_interface_name                = `""+$sa.CustomNetworkInterfaceName + "`""
            $outputtemp +="`nsubnet           = "+$subNet+ "`""


<#

            $outputtemp +="`n = `""+$sa. + "`""
            $outputtemp +="`n = `""+$sa. + "`""
            $outputtemp +="`n = `""+$sa. + "`""
            $outputtemp +="`n = `""+$sa. + "`""
            $outputtemp +="`n = `""+$sa. + "`""
            $outputtemp +="`n = `""+$sa. + "`""
#>

            $outputtemp +="`nresource_group_name = "+$sa.ResourceGroupName + "`""
            
            $outputtemp += "`n}`n,"
        }
    }
#            Write-Output $outputtemp
#####   
}



<#
#build the private link service




#Build the endpoint
resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_private_link_service.example.id
    is_manual_connection           = false
  }
}

#>