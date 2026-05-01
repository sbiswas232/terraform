# Create Resource Group & Storage Account by Azure-CLI
az login

az login --tenant "#####################"

az group create --name <RG_NAME> --location <LOCATION>

az group create --name "tfbackend-rg" --location "eastus"

az storage account create -n "project01may26tfbackend" -g "tfbackend-rg" -l "eastus" --sku Standard_LRS
