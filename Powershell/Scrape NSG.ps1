﻿<#
.Synopsis
A script used to export all NSGs rules in all your Azure Subscriptions

.DESCRIPTION
A script is used to get the list of all Network Security Groups (NSGs) in all your Azure Subscriptions.
Finally, it will export the report into a CSV file in your Azure Cloud Shell storage.

.Notes
Created : 04-January-2021
Updated : 02-March-2023
Version : 3.2
Author : Charbel Nemnom
Twitter : @CharbelNemnom
Blog : https://charbelnemnom.com
Disclaimer: This script is provided "AS IS" with no warranties.
#>

#! Install Az Module If Needed
function Install-Module-If-Needed {
param([string]$ModuleName)
if (Get-Module -ListAvailable -Name $ModuleName -Verbose:$false) {
Write-Host "Module '$($ModuleName)' already exists, continue..." -ForegroundColor Green
}
else {
Write-Host "Module '$($ModuleName)' does not exist, installing..." -ForegroundColor Yellow
Install-Module $ModuleName -Force -AllowClobber -ErrorAction Stop
Write-Host "Module '$($ModuleName)' installed." -ForegroundColor Green
}
}

#! Install Az Accounts Module If Needed
Install-Module-If-Needed Az.Accounts

#! Install Az Network Module If Needed
Install-Module-If-Needed Az.Network

#! Check Azure Connection
Try {
Write-Verbose "Connecting to Azure Cloud..."
Connect-AzAccount -ErrorAction Stop -WarningAction SilentlyContinue | Out-Null
}
Catch {
Write-Warning "Cannot connect to Azure Cloud. Please check your credentials. Exiting!"
Break
}

$azSubs = Get-AzSubscription

foreach ( $azSub in $azSubs ) {
Set-AzContext -Subscription $azSub | Out-Null
$azSubName = $azSub.Name

$azNsgs = Get-AzNetworkSecurityGroup | Where-Object {$_.Id -ne $NULL}

foreach ( $azNsg in $azNsgs ) {
# Export custom rules
Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $azNsg | `
Select-Object @{label = 'NSG Name'; expression = { $azNsg.Name } }, `
@{label = 'NSG Location'; expression = { $azNsg.Location } }, `
@{label = 'Rule Name'; expression = { $_.Name } }, `
@{label = 'Source'; expression = { $_.SourceAddressPrefix } }, `
@{label = 'Source Application Security Group'; expression = { $_.SourceApplicationSecurityGroups.id.Split('/')[-1] } },
@{label = 'Source Port Range'; expression = { $_.SourcePortRange } }, Access, Priority, Direction, `
@{label = 'Destination'; expression = { $_.DestinationAddressPrefix } }, `
@{label = 'Destination Application Security Group'; expression = { $_.DestinationApplicationSecurityGroups.id.Split('/')[-1] } }, `
@{label = 'Destination Port Range'; expression = { $_.DestinationPortRange } }, `
@{label = 'Resource Group Name'; expression = { $azNsg.ResourceGroupName } } | `
Export-Csv -Path "c:\temp\$azSubName-nsg-rules.csv" -NoTypeInformation -Append -force
# Or you can use the following syntax to export to a single CSV file and to a local folder on your machine
# Export-Csv -Path ".\Azure-nsg-rules.csv" -NoTypeInformation -Append -force

# Export default rules
Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $azNsg -Defaultrules | `
Select-Object @{label = 'NSG Name'; expression = { $azNsg.Name } }, `
@{label = 'NSG Location'; expression = { $azNsg.Location } }, `
@{label = 'Rule Name'; expression = { $_.Name } }, `
@{label = 'Source'; expression = { $_.SourceAddressPrefix } }, `
@{label = 'Source Port Range'; expression = { $_.SourcePortRange } }, Access, Priority, Direction, `
@{label = 'Destination'; expression = { $_.DestinationAddressPrefix } }, `
@{label = 'Destination Port Range'; expression = { $_.DestinationPortRange } }, `
@{label = 'Resource Group Name'; expression = { $azNsg.ResourceGroupName } } | `
Export-Csv -Path "c:\temp\$azSubName-nsg-rules.csv" -NoTypeInformation -Append -force
# Or you can use the following syntax to export to a single CSV file and to a local folder on your machine
# Export-Csv -Path ".\Azure-nsg-rules.csv" -NoTypeInformation -Append -force

}
}