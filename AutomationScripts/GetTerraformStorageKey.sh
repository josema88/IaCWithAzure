#!/usr/bin/env bash

# This script will fetch storage key which is required in terraform file to authenticate backend storage account

az storage account keys list -g MyResourceGroup -n MyStorageAccount