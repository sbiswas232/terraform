Login to Azure cloud, Create a Resource Group & a VM of Ubuntu under this Resource Group

Connect the VM by SSH, Install Terraform & Azure CLI

Create a Storage Account & a Container wihin this Storage Account under the Resource Group which was created by Console UI

Use data block to findout the resource group details

In backend.tf block I used a custom local backend path as /tmp/terraform-backend/terrafrom.tfstate
