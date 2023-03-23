Connect-AzAccount
Get-AzContext -ListAvailable

$outputfinal=@()
foreach ( $Subscription in $(Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}) )
{
# get the subscription
    if ($Subscription.SubscriptionId -eq '71753224-e8e9-4591-a74c-9ba9f5767223')
    {

    Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
    $azSubName = $azSub.Name
    $ipc=Get-AzNetworkInterface # -ResourceGroupName gh-networking
#now loop through all the configs and prep for export
foreach ($ip in $ipc)
{
    $outputtemp = "" | SELECT  Name	, AuxiliaryMode,DisableTcpStateTracking,DnsSettings,DnsSettingsText,EnableAcceleratedNetworking,EnableIPForwarding,Etag,ExtendedLocation,ExtendedLocationText,HostedWorkloads,Id,IpConfigurations,IpConfigurationsText,Location,MacAddress,NetworkSecurityGroup,NetworkSecurityGroupText,Primary,PrivateEndpoint,PrivateEndpointText,ProvisioningState,ResourceGroupName,ResourceGuid	,Tag	,TagsTable	,TapConfigurations,TapConfigurationsText,Type	,VirtualMachine,VirtualMachineText,VnetEncryptionSupported
    $outputtemp.AuxiliaryMode=$ip.AuxiliaryMode
    $outputtemp.DisableTcpStateTracking=$ip.DisableTcpStateTracking
    $outputtemp.DnsSettings=$ip.DnsSettings
    $outputtemp.DnsSettingsText=$ip.DnsSettingsText
    $outputtemp.EnableAcceleratedNetworking=$ip.EnableAcceleratedNetworking
    $outputtemp.EnableIPForwarding=$ip.EnableIPForwarding
    $outputtemp.Etag=$ip.Etag
    $outputtemp.ExtendedLocation=$ip.ExtendedLocation
    $outputtemp.ExtendedLocationText=$ip.ExtendedLocationText
    $outputtemp.HostedWorkloads=$ip.HostedWorkloads
    $outputtemp.Id=$ip.Id
    $outputtemp.IpConfigurations=$ip.IpConfigurations
    $outputtemp.IpConfigurationsText=$ip.IpConfigurationsText
    $outputtemp.Location=$ip.Location
    $outputtemp.MacAddress=$ip.MacAddress
    $outputtemp.Name=$ip.Name
    $outputtemp.NetworkSecurityGroup=$ip.NetworkSecurityGroup
    $outputtemp.NetworkSecurityGroupText=$ip.NetworkSecurityGroupText
    $outputtemp.Primary=$ip.Primary
    $outputtemp.PrivateEndpoint=$ip.PrivateEndpoint
    $outputtemp.PrivateEndpointText=$ip.PrivateEndpointText
    $outputtemp.ProvisioningState=$ip.ProvisioningState
    $outputtemp.ResourceGroupName=$ip.ResourceGroupName
    $outputtemp.ResourceGuid=$ip.ResourceGuid
    $outputtemp.Tag=$ip.Tag
    $outputtemp.TagsTable=$ip.TagsTable
    $outputtemp.TapConfigurations=$ip.TapConfigurations
    $outputtemp.TapConfigurationsText=$ip.TapConfigurationsText
    $outputtemp.Type=$ip.Type
    $outputtemp.VirtualMachine=$ip.VirtualMachine
    $outputtemp.VirtualMachineText=$ip.VirtualMachineText
    $outputtemp.VnetEncryptionSupported=$ip.VnetEncryptionSupported
    $outputfinal += $outputtemp
}
}
}

$outputfinal | Export-Csv c:/temp/IPC_"$((Get-Date).ToString("yyyyMMdd_HHmmss")).csv" -NoTypeInformation