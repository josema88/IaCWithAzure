# Azure Infrastructure Deployment with Terraform (IaC) and automated with Azure DevOps

This is a sample that allows to create infrastructure in Azure cloud using IaC concept with tools such as Terraform and Azure DevOps.

On this project you will be able to create a PaS Azure Resource called [App Service](https://azure.microsoft.com/en-us/services/app-service/). This Azure resource will allow to you to deploy your web app, for this sample a .net web app. 

Within this repo is a folder called Terraform and a file called [appService.tf](https://github.com/josema88/IaCWithAzure/blob/master/Terraform/appService.tf) that contains the definition of the infrastructure that will be deployed on Azure. The file contains the definition for the following Azure resources:
 * Resource Group
 * App Service Plan
 * App Service

Each resource has its required configurations such as the name and other parameters. If you use the terraform file from this repo you should change the name for your App Service resource since this should be a unique name within azure cloud.

# Requirements

  * Install [Azure CLI](https://docs.bitnami.com/azure/faq/administration/install-az-cli/) (if you want to test from your computer)
  * Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) (if you want to test from your computer)
  * Create an Azure account (.
  * Create an Azure DevOps account.


# Create Azure DevOps Project

You must create your Azure DevOps project that will contain the automated pipelines that deploy the infraestructure to the cloud.

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
These pipeline variables will be used in order to parametrize names for some resources and avoid the hardcoding withing the scripts. These variables will be used to create the Azure resources that will store the Terraform Backend. The variable "TerraformStorageAccount" refers to the name that you will set to the storage account in Azure that will stores the Terraform Backend, this variable should be different for any implementation since this should be a unique name within Azure Cloud.
![AzDevops11](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps11.png)

### Terraform Backend 
By default, Terraform stores state locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated. With remote state, Terraform writes the state data to a remote data store. For this sample we will use a Terraform CLI task that allows to create an Azure storage account and storage container to store Terraform state if this not exists yet. For more information on Terraform remote state click [here](https://www.terraform.io/docs/state/remote.html)

### Terraform Cycle
When running Terraform in automation, the focus is usually on the core plan/apply cycle. The main Terraform workflow is the following:

![TFcycle](https://github.com/josema88/IaCWithAzure/blob/master/Images/terraformworkflow.png)

i. Initialize the Terraform working directory.

ii. Produce a plan for changing resources to match the current configuration.

iii. Apply the changes described by the plan.

The following tasks will allow you to implement the terraform cycle.
 
### Add Task - Terraform Init
First you should install the extension in order to use the terraform task, select the extension created by Charles Zipp.
![AzDevops14](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps14.png)
![AzDevops15](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps15.png)
![AzDevops16](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps16.png)

Once the extension is installed in your Azure DevOps you can add the task for Terraform Install, this task will guarantee that the agent that runs the command has Terraform installed. 
![AzDevops17](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps17.png)
![AzDevops17_1](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps17_1.png)

Add Terraform CLI task to perform the Init Stage, you should select the command Init and for the Configuration directory you should point to the artifact configured before (repo and folder that contains the terraform files).
![AzDevops20](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps20.png)
![AzDevops21](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps21.png)

Configure the Azure Resource Manager section in order to set the Terraform Backend that will be located in azure, we should use the Pipeline variables configured previously.
![AzDevops22](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps22.png)

This task runs terraform init command. The terraform init command looks through all of the *.tf files in the current working directory and automatically downloads any of the providers required for them. In this example, it will download Azure provider as we are going to deploy Azure resources. For more information about terraform init command click [here](https://www.terraform.io/docs/commands/init.html).

### Add Task - Terraform Plan
Add Terraform CLI task like the init task, but for this one you should select the command Plan. You should set the Configuration Directory like the previous task. Also set the "Environment Azure Subscription" that should point to your Azure service connection configured before, you should authorize the connection if necessary. 
![AzDevops23](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps23.png)

The terraform plan command is used to create an executi]on plan. Terraform determines what actions are necessary to achieve the desired state specified in the configuration files. This is a dry run and shows which actions will be made. For more information about terraform plan command click [here](https://www.terraform.io/docs/commands/plan.html).

### Add Task - Terraform Apply
Add Terraform CLI task like previous tasks, but for this one you should select the command Apply. You should set the Configuration Directory like the previous task. Also set the "Environment Azure Subscription" that should point to your Azure service connection configured before.
![AzDevops24](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps24.png)

This task will run the terraform apply command to deploy the resources to Azure Cloud.

### Save your Pipeline
Once the pipeline configuration is completed set a Name on it and save changes.
![AzDevops25](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps25.png)

### Launch your Pipeline
The Pipeline is now available to be selected and Create a Release, this action will start the execution of the pipeline and its tasks. 
![AzDevops26](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps26.png)
![AzDevops27](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps27.png)
![AzDevops28](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps28.png)


When the execution of the pipeline is finished you will be able the see the new infraestructure created in Azure.
![AzDevops29](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps29.png)
![AzDevops30](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps30.png)

Within the RG for the App Service you will see the new infrastructure.
![AzDevops31](https://github.com/josema88/IaCWithAzure/blob/master/Images/AzDevOps31.png)


Now a .net web app can be deployed to the new App Service.


