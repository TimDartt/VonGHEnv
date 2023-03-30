#Get-AzApiManagementApi

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
    $apiMan = ""
    if ($Subscription.SubscriptionId -eq $SubId)  # the scaffolding Sub ID
    {

        Select-AzSubscription -SubscriptionId $Subscription.SubscriptionId
        ####    replace the next command with the appropriate azure fetchs
        $AmA=Get-AzApiManagement # -ResourceGroupName gh-networking
        foreach ($sa in $AmA)
        {
            $outputtemp += "{"
            $outputtemp += "`nName                    = `"" + $sa.Name + "`""
            $outputtemp += "`nResourceGroup           = `"" + $sa.ResourceGroupName + "`""
            $outputtemp += "`nSku                     = `"" + $sa.Sku + "`"_0"
            $outputtemp += "`nEnableClientCertificate = " + $sa.EnableClientCertificate
            $outputtemp += "`n},`n"
            $ApiMgmtContext = New-AzApiManagementContext -ResourceGroupName $sa.ResourceGroupName -ServiceName $sa.Name
            $Apis = Get-AzApiManagementApi -Context $ApiMgmtContext
            foreach($ap in $apis){
                $apiman += "{"
                $apiman += "`nname = `"" +$ap.Name + "`""
                $apiman += "`nResourceGroupName = `"" +$ap.ResourceGroupName + "`""
                $apiman += "`napi_management_name = `"" +$sa.Name + "`""
                $apiman += "`nprotocols = `""+ $ap.Protocols + "`""
                $apiman += "`nPath = `"" +$ap.Path + "`""
                $apiman += "`n},`n"
            }
            Write-Output $apiman
        }
      }
      Write-Output $outputtemp
#####   
}



<#
  name                = "example-api"
  api_management_name = azurerm_api_management.example.name
  revision            = "1"
  display_name        = "Example API"
  path                = "example"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
  }
#>