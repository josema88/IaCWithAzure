# IaCWithAzure

This is a sample that allows to create infrastructure in Azure cloud using IaC concept with tools such as Terraform, Ansible and Azure Resource Manager.

  - Type some Markdown on the left
  - See HTML in the right
  - Magic

# Requirements

  * Install [Azure CLI](https://docs.bitnami.com/azure/faq/administration/install-az-cli/)
  * Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 
  * Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)


# Create Azure DevOps Project

You must create your Azure DevOps project that will contain the automated pipelines that deploy the infraestructure to the cloud.
Where I use `{YOURORG}`, you'll replace with the organization that you create.

#### Create New Organization
* Open https://dev.azure.com
* Create a new organization 

![AzDevops1](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps1.png)

![AzDevops2](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps2.png)

#### Create Project
* Create the first project - name it `AzBootCamp2019`

#### Authorize your Azure Cloud subscription
* Add a service connection for your Azure Subscription 
![AzDevops3](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps3.png)

# Create Automated Pipeline
After you create your organization and project within Azure Devops you can proceed to create your automated pipeline.

### Create a Release Pipeline
* Create a new Release Pipeline 
![AzDevops4](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps4.png)
* Add an artifact, in this case your Github repo where your terraform code is hosted. You should add a new connection to your github in services management.
![AzDevops5](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps5.png)
* Add a stage, e.g.: Dev or Prod. This stage should be an empty job.
![AzDevops6](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps6.png)
![AzDevops7](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps7.png)
![AzDevops8](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps8.png)

#### Create Terraform Backend Task
Select the Azure CLI task. Select the Azure subscription from the drop-down list and click Authorize to configure Azure service connection. Get your automation script from the repo. Note that the bash script will receive some arguments.
![AzDevops9](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps9.png)
![AzDevops10](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps10.png)

By default, Terraform stores state locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated. With remote state, Terraform writes the state data to a remote data store. Here we are using Azure CLI task to create Azure storage account and storage container to store Terraform state. For more information on Terraform remote state click [here](https://www.terraform.io/docs/state/remote.html)
