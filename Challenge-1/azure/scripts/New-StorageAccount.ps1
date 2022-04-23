<#
.SYNOPSIS

Deploy Storage Account.

.DESCRIPTION

Code is used to deploy Storage Account (SA) in Azure Infrastructure.
Deployable resources can be deployed in either DEV, TEST or PROD Cloud Core subscriptions, based on parameter input.

.PARAMETER ResourceGroupName

Resource group name where SA will be deployed.

.PARAMETER SubscriptionID

ID of the subscription where to deploy SA.

.PARAMETER SaName

Name of Storage Account.

.PARAMETER TagBusinessOwner

Tag used in deployed resources to specify resource Business Owner.

.PARAMETER TagTechnicalOwner

Tag used in deployed resources to specify resource Technical Owner.

.PARAMETER PathtoTemplate

Path to the ARM template file of the Storage Account

.INPUTS

None. You cannot pipe objects to this script.

.OUTPUTS

PSResourceGroupDeployment Class from ARM deployment.

.EXAMPLE

None.

.LINK

"templates/AzureStorageAccount.json"
    - Storage Accounts deployment ARM template.

#>

Param(
    [string] [Parameter(Mandatory = $true)] $ResourceGroupName,
    [string] [Parameter(Mandatory = $true)] $SubscriptionID,
    [string] [Parameter(Mandatory = $true)] $SaName,
    [string] [Parameter(Mandatory = $true)] $PathtoTemplate,    
    [string] [Parameter(Mandatory = $false)] $TagBusinessOwner,
    [string] [Parameter(Mandatory = $false)] $TagTechnicalOwner
)

Set-AzContext $SubscriptionID

# Verify if the Storage Account Exists
$checkStorageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -StorageAccountName $SaName -ErrorAction SilentlyContinue
if (!$checkStorageAccount) {
  Write-Host "The Storage Account does not exist and hence creating it."
  $armStorageAccount = $PathtoTemplate + "/AzureStorageAccount.json"
  $saARMArguments = @{
        saName = $SaName 
        tagBusinessOwner = $TagBusinessOwner 
        tagTechnicalOwner = $TagTechnicalOwner 
   }

  New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $armStorageAccount @saARMArguments -Verbose -Force
  Start-Sleep -s 10   

  # Validate if the Storage Account has been created
  $validate = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -StorageAccountName $SaName -ErrorAction SilentlyContinue
  if($validate) {
      Write-Host "The Storage Account has been successfully created."
  }
  else {
      Write-Host "The Storage Account cannot be created. Terminating the script."
  }
}
else {
    Write-Host "The Storage Account already exists."
}