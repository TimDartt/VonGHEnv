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
        $storageAccts=Get-AzStorageAccount # -ResourceGroupName gh-networking
        foreach ($sa in $storageAccts)
        {
            # Write-Output $sa -- use to see the output 
            #### The following is used to create the output
            $outputtemp += "{`nname                    = `""+$sa.StorageAccountName + "`""
            $outputtemp += "`nresource_group_name      = `""+$sa.ResourceGroupName+ "`""
            $outputtemp += "`naccount_tier             = `"Standard`""
            $outputtemp += "`naccount_replication_type = `"RAGRS`""
            $outputtemp += "`naccount_kind             = `""+$sa.Kind+ "`""
            $outputtemp += "`n}`n,"
        }
      }
            Write-Output $outputtemp
#####   
}
