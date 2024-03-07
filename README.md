# DevOps_LearningPath

## DevOps (software development [Dev] and IT operations [Ops])

Describes a collection of specific tools and practices, to connect the development environment with the operations and deployment environment. The goal is to improve and shorten the system development life cycle through automation within these processes.
People, who are specific trained for managing the DevOps cycle, are called DevOps Engineers.
A few Key Concepts of DevOps are CI (Continous Integration) and CD (Continious Delivery/Deployment).

#### Continuous Integration

Codechanges are merged back to the mainbranch as often as possible. Before that, these codes run through an automated test-environment, to ensure, that there are no errors and that the compatibility is given.

#### Continnuous Delivery

Is an extension to CI, whre all changes are implemented to a test- and/or a production-environment. The advantge is, if you use it continiously, that you always deploy small batches of code, which are verfified and tested.

#### Continuous Deployment

This is another extension to Continuous Delivery, where all changes will automaticly deployed to the customer site, completly tested automaticly. The advantge is, that the customer can see directly which changes are made and can also be sure, that these codeparts are validated. This method reduces pressure on the development team, because there is no official "release day" for new features.

## IoT (Internet of Things)

IoT is the connection between sensors, machines, devices and the internet whose goal is to share its results to eachother to work with.
Usecases examples for IoT are found in the industry, administration of power grids and intelligent logistics.

## Bicep

Bicep is domain-specific-language (DSL), that is used to deploy Azure Resources. It's purpose is not to be a programming language, but rather an abstraction for the Azure Resource Manager (ARM) templates. You could also use JSON Datas to define your Resource Properties, but Bicep is more reader friendly.  
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep

## Azure Subscription

The Azure Subscription is a contract between an user and Microsofts Azure Portal, to use its cloud plattform and services. Usualy the users pay like the Pay as you use principle. Every user has 1.000.000 requests and 400 GB per month.

## Resource Groups

Resource Groups are structures made of defferent resource types like virtual machines, discs or network interfaces. Groups are indipendet from the types included in this group. You can also grant accesses or set boundris to different groups to specific users, usergroups or devices.

## Blob Storage

Blob Storage is short for "Binary large objects" and is mostly used to store large datas, like pictures, music or backup-recoveries. There are two types to access Blob Storages.

#### Hot Access Tier

Developed for datas, who are moved frequently. This option is more expensive.

#### Cold Access Tier

Developed for datas, who are stored permanently. This option is cheaper then the Hot Access Tier.

#### Advantages Blob Storage

Suitable for all kinds of data, like big data or unstructured data.
Worldwide access through HTTP-requests.
Highly scalable.

## git source control

Is also known as version control. It's purpose is to keep track on the modifications made to the code and to turn back to an older state if mistakes were made. Software to implement version controls are called VCS, Version Control Systems or SCM, Source Control Management. Git is one of the most popular distributed VCS (DVCS) and it's free and open source.

#### Pull request

A Pull Request is a request, to deploy and merge the changes that you made on your branch to the main branch. Employees and other developers can see the changes you made on your request and are able to accept or deny these changes.

#### Branch

Branches are different versions of the project. The main branch is the branch, where all pull requests are merged into. This branch is also the one, what will get to the customer and is the current state of the project, where just accepted changes are included. The side branches are the ones where developers are working on and try new features.

#### Commit

Commits are changes made on your branch wich can be saved as little groups. Every commit has its own uniqe ID, called Hash. In a commit is documented what was changed, when it was changed and who made that change.

## GitHub

GitHib is a platform, that allows developers to create, store, manage and share their codes and projects. It uses the git software, which provides all the features of the distributed version control system (DVCS).

#### Repository

A repository is the main basic element of GitHub. It contains all of your code, files and each file history and can be shared with different collaborators. It also can be set to public or private.

#### Action

GitHub Action is a CI/CD platform, that allows the user to automate the build, test and deployment pipeline. It can be triggered when an event occurs, such as a pull rquest being opened or an issue being crated. This process of different actions is called a workflow. Your code will run through this workflow, if your desired event is triggered.

#### Service Principal - Azure Deployment

Azure Service Principal acts as an identity for the applications, allow and deny requests within the Azure Resource Group automatically, depends on the way he is programmed.
