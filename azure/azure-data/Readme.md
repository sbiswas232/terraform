Login to Azure cloud, Create a Resource Group & a VM of Ubuntu under this Resource Group

Connect the VM by SSH, Install Terraform & Azure CLI

Create a Storage Account & a Container wihin this Storage Account under the Resource Group which was created by Console UI

Use data block to findout the resource group details

In backend.tf block I used a custom local backend path as /tmp/terraform-backend/terrafrom.tfstate

Install Terrafrom in Ubuntu in Azure Cloud:
-------------------------------------------------------------------------------------
# nano install-terraform-azcli.sh 

#!/bin/bash

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform -y

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

terraform --version

az --version

# Terraform Commands:

az login

az login --tenant <Tenant-ID>      #(NOTE: Copy the Code & Click on the URL to open it on browser & Paste the Code)

terraform init

terraform init -reconfigure

terraform fmt --recursive

terraform plan -var subscription=<"Subscription-ID">

terraform apply -var subscription=<"Subscription-ID">
  
terraform destroy -var subscription=<"Subscription-ID">
   
ls -l /tmp/terraform-backend/terraform.tfstate

ls -la /tmp/terraform-backend/terraform.tfstate.backup
