<#
.SYNOPSIS

This script gets metadata of the Azure Instance. This is doable through Azure Instance Metadata Service.

.DESCRIPTION

The Azure Instance Metadata Service (IMDS) provides information about 
- currently running virtual machine instances. 
- SKU, storage, network configurations, and upcoming maintenance events.

.INPUTS

None.

.OUTPUTS
json formmated-output.

.EXAMPLE

None.

.LINK

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/instance-metadata-service?tabs=windows

#>

Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -NoProxy -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | ConvertTo-Json -Depth 64