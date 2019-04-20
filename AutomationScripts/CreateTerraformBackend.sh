#! bin/bash
#This script will create: an Azure resource group, an Storage account and a Storage container which will be used to store terraform state

az group create --locataion eastus2 --name $0

az storage account create --name $1 --resource-group $0 --location eastus2 --sku Standard_LRS

az storage container create --name terraform --account-name $1