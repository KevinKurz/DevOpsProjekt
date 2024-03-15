# Azure Resource Deployment Readme

This readme provides instructions for deploying Azure resources using the provided ARM template.

## Prerequisites

Ensure you have the following prerequisites before deploying the resources:

- Azure subscription
- Azure CLI installed
- Git installed

## Deployment Steps

Follow these steps to deploy the Azure resources:

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/your-repository-url.git
    ```

2. Navigate to the cloned repository directory:

    ```bash
    cd your-repository-directory
    ```

3. Modify the parameters in the `azuredeploy.parameters.json` file according to your requirements.

4. Deploy the resources using the Azure CLI:

    ```pwsh
    az deployment group create --resource-group your-resource-group-name --template-file azuredeploy.json --parameters azuredeploy.parameters.json
    ```

   Replace `your-resource-group-name` with the name of your Azure resource group.

## Parameters

### App Service Plan

- **appServicePlanName**: Name for the Azure App Service Plan.
- **appServiceName**: Name for the Azure App Service.
- **location**: Azure region where the resources will be deployed.
- **textToReplaceSubtitleWith**: Text to replace the default subtitle with in the application.

### Source Control Integration

- **repositoryBranch**: Branch of the repository for deployment.

## Description

This ARM template deploys an Azure App Service Plan, an Azure App Service, and integrates it with a specified GitHub repository for source control.

## App Service Plan Template

- **Name**: `appServicePlanName`
- **Location**: `location`
- **SKU**: `F1` (Free tier)

## App Service Template

- **Name**: `appServiceName`
- **Location**: `location`
- **Server Farm ID**: `appServicePlan.id`
- **HTTPS Only**: Enabled
- **App Settings**:
  - `TEXT_TO_REPLACE_SUBTITLE_WITH`: Text specified in `textToReplaceSubtitleWith`.
  - `SCM_DO_BUILD_DURING_DEPLOYMENT`: Build the application during deployment (set to `true`).
  - `WEBSITE_NODE_DEFAULT_VERSION`: Default node version set to `~20`.
- **Public Network Access**: Enabled

## Source Control Integration Template

- **Repository URL**: `https://github.com/KevinKurz/DevOpsProjekt`
- **Branch**: `repositoryBranch`
- **Manual Integration**: Enabled
