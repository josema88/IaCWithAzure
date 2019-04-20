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


