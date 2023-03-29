### Get-AzPrivateDnsZone
# get all the storage account info
# 
# first connect to azure
Connect-AzAccount
clear


# Set the sub ID to pull from 
$SubId = '71753224-e8e9-4591-a74c-9ba9f5767223'

#next get all the 
Get-AzContext #-ListAvailable

$outputfinal=@()   # create the output string
foreach ( $Subscription in $(Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}) )    # get all the subscriptions
{
    $outputtemp = ""
    $recordASet = ""
    $recordSOASet = ""
# get the subscription
    if ($Subscription.SubscriptionId -eq $SubId)  # the scaffolding Sub ID
    {

        Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
####    replace the next command with the appropriate azure fetchs
        $pdnzs =Get-AzPrivateDnsZone # -ResourceGroupName gh-networking
        foreach ($sa in $pdnzs)
        {
             #Write-Output $sa -- use to see the output 
#### The following is used to create the output 

            $outputtemp += "{`nname                    = `""+$sa.Name + "`""
            $outputtemp += "`nresource_group_name      = `""+$sa.ResourceGroupName+ "`""
           
            $pdnzsRS =Get-AzPrivateDnsRecordSet -ZoneName $sa.Name -ResourceGroupName $sa.ResourceGroupName
            foreach($rs in $pdnzsRS)
            {
               switch ($rs.RecordType)
               { 
                   "A"
                   {
                       # Write-Output $rs
                       $recordASet +="{"
                       $recordASet +="`nname                =`"" + $rs.Name + "`""
                       $recordASet +="`nzone_name           =`"" + $rs.ZoneName + "`""
                       $recordASet +="`nresource_group_name =`"" + $rs.ResourceGroupName + "`""
                       $recordASet +="`nttl                 ="   + $rs.Ttl 
                       $recordASet +="`nrecords             =[`""   + $rs.Records + "`"]"
                       $recordASet +="`n},`n"
                       break
                   }
                   "SOA"
                   {
                   
                       $recordSOASet +="{"
                       $recordSOASet +="`nzone_name           =`"" + $rs.ZoneName + "`""
                       $recordSOASet +="`nresource_group_name =`"" + $rs.ResourceGroupName + "`""
                       $recordSOASet +="`n},`n"
                       break

                   }
                   default
                   {
                    Write-Output "***** Missing RecordType : " $rs.RecordType
                   }
               }

            }
            #Write-Output $pdnzsRS 
            $outputtemp += "`n}`n,"

        }
        Write-Output "**** Private DNS Zones"
        Write-Output $outputtemp
        Write-Output "**** A records"
        Write-Output $recordASet
        Write-Output "**** SOA records"
        Write-Output $recordSOASet
      }
            


}

<#
Name                                           : stg.vtoxford.org
ResourceId                                     : /subscriptions/71753224-e8e9-4591-a74c-9ba9f5767223/resourceGroups/gh-scaffold-dns/providers/Microsoft.Network/privateDnsZones/stg.vtoxford.org
ResourceGroupName                              : gh-scaffold-dns
Location                                       : 
Etag                                           : dcba072b-a82f-4b73-a54b-0a6a8e09aaa0
Tags                                           : {}
NumberOfRecordSets                             : 3
MaxNumberOfRecordSets                          : 25000
NumberOfVirtualNetworkLinks                    : 0
MaxNumberOfVirtualNetworkLinks                 : 1000
NumberOfVirtualNetworkLinksWithRegistration    : 0
MaxNumberOfVirtualNetworkLinksWithRegistration : 100
#>