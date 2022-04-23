# IaC
## Challenge-1
This is a simple pipeline to create the Storage Account across the 3 enviornments - DEV, TEST, PROD. These 3 enviorment are in 3 different subscription.
The pipeline "deploy-storage.yaml" accepts the enviormentname and also the storage account name. It deploys the Storage Account in any of the subscription based on the enviorment and the name that you provide.
Pipeline triggers the .ps1 script that references the ARM template for Storage Account.
The CD can be controlled via the ARM Template.


