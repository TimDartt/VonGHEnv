# connect to Azure account
Connect-AzAccount
Get-AzContext
foreach ( $Subscription in $(Get-AzSubscription| Where-Object {$_.State -ne "Disabled"}) )
{
    # get the subscription
    if ($Subscription.SubscriptionId -eq '71753224-e8e9-4591-a74c-9ba9f5767223')
    {
        Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
        Get-AzNetworkInterface # -ResourceGroupName gh-networking
    }
}
