# IaCWithAzure

This is a sample that allows to create infrastructure in Azure cloud using IaC concept with tools such as Terraform and Azure DevOps.

On this project you will be able to create a PaS Azure Resource called [App Service] https://azure.microsoft.com/en-us/services/app-service/ . This Azure resource will allow to you to deploy your web app, for this sample a .net web app. 

# Requirements

  * Install [Azure CLI](https://docs.bitnami.com/azure/faq/administration/install-az-cli/)
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

#### Select a Ubuntu OS Agent
For this sample you should use an agent that runs with Ubuntu OS since the scripts are written in bash.
![AzDevops18](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps18.png)

#### Create Pipeline variables
These pipeline variables will be used in order to parametrize names for some resources and avoid the hardcoding withing the scripts.
![AzDevops11](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps11.png)

#### Add Task - Create Terraform Backend 
Select the Azure CLI task. Select the Azure subscription from the drop-down list and click Authorize to configure Azure service connection. Get your automation script from the repo. Note that the bash script will receive some arguments.
![AzDevops9](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps9.png)
![AzDevops10](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps10.png)

Also some environment variables should be added, these env variables should take the values from the Pipeline variables previously created.
![AzDevops12](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps12.png)


By default, Terraform stores state locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated. With remote state, Terraform writes the state data to a remote data store. Here we are using Azure CLI task to create Azure storage account and storage container to store Terraform state. For more information on Terraform remote state click [here](https://www.terraform.io/docs/state/remote.html)

#### Add Task - Get Storage Account Key
Select the Azure CLI Task. Select the Azure subscription from the drop-down list. Get your automation script from the repo.
![AzDevops13](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps13.png)

To configure the Terraform backend we need Storage account access key. Here we are using Azure PowerShell task to get the Access key of the storage account provisioned in the previous step.

### Add Task - Terraform Init
First you should install the extension in order to use the terraform task, select the extension created by Charles Zipp.
![AzDevops14](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps14.png)
![AzDevops15](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps15.png)
![AzDevops16](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps16.png)

Once the extension is installed in your Azure DevOps you can add the task for Terraform Install, this task will guarantee that the agent that runs the command has Terraform installed. 
![AzDevops17](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps17.png)
![AzDevops17_1](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps17_1.png)

Select the Terraform CLI task. Select Azure service connection from the drop-down.
![AzDevops17](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps17.png)

This task runs terraform init command. The terraform init command looks through all of the *.tf files in the current working directory and automatically downloads any of the providers required for them. In this example, it will download Azure provider as we are going to deploy Azure resources. For more information about terraform init command click here


