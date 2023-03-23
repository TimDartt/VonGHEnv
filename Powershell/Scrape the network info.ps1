# connect to Azure account
Connect-AzAccount

$outputfinal=@()
#get all the subscriptions and loop through them
foreach ( $Subscription in $(Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}) )
{
# get the subscription
Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
#all the networks in the subscription 
$nets=Get-AzVirtualNetwork
#now loop through all the networks and prep for export
foreach ($net in $nets)
{
#each subnet
$snets=$net.Subnets
foreach ($snet in $snets)
{
$outputtemp = "" | SELECT  VNET,VNET_AddressSpace,VNET_Location,ResourceGroup,Subnet_Name,Subnet_AddressPrefix
$outputtemp.VNET=$net.Name
$outputtemp.VNET_AddressSpace=$net.AddressSpace.AddressPrefixes.trim('{}')
$outputtemp.VNET_Location=$net.Location
$outputtemp.ResourceGroup=$net.ResourceGroupName
$outputtemp.Subnet_Name=$snet.Name
$outputtemp.Subnet_AddressPrefix=$snet.AddressPrefix.trim('{}')
$outputfinal += $outputtemp
}
}
}
#Export the data to a csv table
###$outputfinal | Format-Table
$outputfinal | Export-Csv c:/temp/NETS_"$((Get-Date).ToString("yyyyMMdd_HHmmss")).csv" -NoTypeInformation