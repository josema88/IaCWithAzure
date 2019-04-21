#!/usr/bin/env bash

# This script will fetch storage key which is required in terraform file to authenticate backend storage account

MULTILINE=$(az storage account keys list \
    --account-name $TERRAFORM_SA \
    --resource-group $TERRAFORM_RG | jq '.[0].value')

echo "##vso[task.setvariable variable=StorageKey;]${MULTILINE}"

export ARM_ACCESS_KEY=${MULTILINE}