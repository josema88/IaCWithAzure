#!/usr/bin/env bash
#This script will create: an Azure resource group, an Storage account and a Storage container which will be used to store terraform state

az group create --location eastus2 --name $TERRAFORM_RG

az storage account create --name $TERRAFORM_SA --resource-group $TERRAFORM_RG --location eastus2 --sku Standard_LRS

az storage container create --name terraform --account-name $TERRAFORM_SA