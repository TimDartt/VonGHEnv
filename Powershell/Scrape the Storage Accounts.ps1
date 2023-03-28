# get all the storage account info
# 
# first connect to azure
Connect-AzAccount
clear
#next get all the 
Get-AzContext #-ListAvailable

$outputfinal=@()
foreach ( $Subscription in $(Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}) )
{
    $outputtemp = ""
# get the subscription
    if ($Subscription.SubscriptionId -eq '71753224-e8e9-4591-a74c-9ba9f5767223')  # the scaffolding Sub ID
    {

    Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
    $azSubName = $azSub.Name
    $storageAccts=Get-AzStorageAccount # -ResourceGroupName gh-networking
foreach ($sa in $storageAccts)
{
Write-Output $sa
    
    
    $outputtemp += "{`nname                    = '"+$sa.StorageAccountName + "'"
    $outputtemp += "`nresource_group_name      = '"+$sa.ResourceGroupName+ "'"
    $outputtemp += "`naccount_tier             = 'Standard'"
    $outputtemp += "`naccount_replication_type = 'RAGRS'"
    $outputtemp += "`naccount_kind             = '"+$sa.Kind+ "'"
    $outputtemp += "`n}`n,"
    }
    }
    Write-Output $outputtemp
}


#
#resource "azurerm_storage_account" "example" {
#  name                     = "storageaccountname"
#  resource_group_name      = azurerm_resource_group.example.name
#  location                 = azurerm_resource_group.example.location
#  account_tier             = "Standard"
#  account_replication_type = "GRS"

#  tags = {
#    environment = "staging"
#  }
#}
