# UserStory4

As a Product Owner I want to have all the code for the application to be stored in a GitHub Repository. Also, there should be a Deployment from the Main Branch automated on the Azure Resource Group. Authentication should be done with a Service Principal

## Task 0: Create a GitHub Account if you don’t have one already

## Task 1: Create a Repository in GitHub. It can be a private one for your User

## Task 2: Sync your Repository to your local machine and push all the Templates, Scripts and Documentation to it

## Task 3: Setup Service Principal Connection to Azure

An Azure service principal is a security identity used by user-created apps, services, and automation tools to access specific Azure resources. Think of it as a 'user identity' (login and password or certificate) with a specific role, and tightly controlled permissions to access your resources. It only needs to be able to do specific things, unlike a general user identity. It improves security if you only grant it the minimum permissions level needed to perform its management tasks. For example, if a developer creates an application and needs to have an access to a blob storage, the service principal responsible for give the permission to that ressource, depending on the configuration.

Dependent of the role of the Service Principal is he able to give different permissions to your ressource- or ressource groups.

## Task 4: Create a GitHub Action to Deploy your Templates

Important: The directory MUST BE "your_Project_name/.github/workflows/"your_Action_Code.yaml"

## Task 5: Make the Deployment triggered by a commit to the main Branch
