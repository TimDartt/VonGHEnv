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
    $outputASGAssoc = ""
# get the subscription
    if ($Subscription.SubscriptionId -eq '71753224-e8e9-4591-a74c-9ba9f5767223')  # the scaffolding Sub ID
    {

    Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
####    replace the next command with the appropriate azure fetchs
        $endpoints=Get-AzPrivateEndpoint # get all the endpoints in the subscription
        foreach ($ep in $endpoints) {
            # Write-Output $ep 
            $outputtemp += "{`nname                    = '"+$ep.Name + "'"
            $outputtemp += "`nresource_group_name      = '"+$ep.ResourceGroupName+ "'"
            $outputtemp += "`npcustom_network_interface_name      = '"+$ep.custom_network_interface_name+ "'"
            $outputtemp += "`n}`n,"
            # build the ASG associations
            foreach ($asg in $ep.ApplicationSecurityGroupsText)
                {
                # Write-Output $asg
                # Get the substring between the last slash and search string
                $lastSlash = $asg.LastIndexOf("/")
                if ($lastSlash -gt 0){
                    # extract any existing ASG :)
                    $asg = $asg.Substring($lastSlash+1, $asg.IndexOf("`n", $lastSlash) - $lastSlash-3)
                    if ($asg -gt '.'){
                        $outputASGAssoc += "{`nEndPoinName                    = '"+$ep.Name + "'" # set the name of the EP (which will be needed to find the ID of the EP
                        $outputASGAssoc += "`nASGName                    = '" + $asg
                        $outputASGAssoc += "`n}`n,"
                    }
                 }
                }
         
              }

            }
            if ($outputtemp -gt '.') {
            Write-Output '***** Sub ID :' + $Subscription.SubscriptionId
            Write-Output '** EPs '
            Write-Output $outputtemp
            Write-Output '** ASG Assoc '
            Write-Output $outputASGAssoc
            Write-Output '***** '
            }
        }


####    foreach ($sa in $storageAccts)
#        {
            # Write-Output $sa -- use to see the output 
#### The following is used to create the output 
#            $outputtemp += "{`nname                    = '"+$sa.StorageAccountName + "'"
#            $outputtemp += "`nresource_group_name      = '"+$sa.ResourceGroupName+ "'"
#            $outputtemp += "`naccount_tier             = 'Standard'"
#            $outputtemp += "`naccount_replication_type = 'RAGRS'"
#            $outputtemp += "`naccount_kind             = '"+$sa.Kind+ "'"
#            $outputtemp += "`n}`n,"
#            }
#           }
#            Write-Output $outputtemp
#####   
#        }


