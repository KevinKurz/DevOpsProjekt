# Azure Resource Deployment Readme

This readme provides instructions for deploying Azure resources using the provided ARM template and PowerShell script.

## Prerequisites

Ensure you have the following prerequisites before deploying the resources:

- Azure subscription
- Azure CLI installed
- Git installed

## ARM Template

### Parameters

#### Global Variables

- **location**: The Azure region in which all resources are deployed.

#### Storage Variables

- **repositoryBranch**: Standard branch of the repository for deployment.
- **projectName**: Name of the project.
- **skuName**: SKU to use for the IoT Hub.
- **skuUnits**: Number of IoT Hub units.
- **textToReplaceSubtitleWith**: Text to replace the default subtitle with in the application.

### Description

This ARM template deploys the following Azure resources:

- Storage Account
- Container
- IoT Hub
- App Service Plan
- Web App
- Source Control Integration

### IoT Hub

- **Name**: Automatically generated based on project name and unique string.
- **Location**: Same as the deployment location.
- **SKU**: `skuName` with `skuUnits` capacity

### Storage Account

- **Name**: Automatically generated based on project name and unique string.
- **Location**: Same as the deployment location.
- **SKU**: Standard_LRS
- **Kind**: StorageV2

### App Service Plan

- **Name**: `asp-userstory3`
- **Location**: Same as the deployment location
- **SKU**: `F1` (Free tier)

### Web App

- **Name**: `app-userstory3`
- **Location**: Same as the deployment location
- **Server Farm ID**: `appServicePlan.id`
- **HTTPS Only**: Enabled
- **App Settings**:
  - `TEXT_TO_REPLACE_SUBTITLE_WITH`: Text specified in `textToReplaceSubtitleWith`.
  - `SCM_DO_BUILD_DURING_DEPLOYMENT`: Build the application during deployment (set to `true`).
  - `WEBSITE_NODE_DEFAULT_VERSION`: Default node version set to `~20`.
- **Public Network Access**: Enabled

### Source Control Integration

- **Repository URL**: `https://github.com/your-repository-url`
- **Branch**: `repositoryBranch`
- **Manual Integration**: Enabled

## PowerShell Script

### PWSH Parameters

- **$parameters**: Specifies the target environment for deployment (production, test, or development).

### PWSH Description

This PowerShell script facilitates the deployment of Azure resources using Bicep templates based on the specified environment parameter.

## Deployment Steps

Follow these steps to deploy the Azure resources:

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/your-repository-url.git
    ```

2. Navigate to the cloned repository directory:

    ```pwsh
    cd your-repository-directory
    ```

3. Modify the parameters in the `azuredeploy.parameters.json` file according to your requirements.

4. Deploy the resources using the Azure CLI:

    ```pwsh
    az deployment group create --resource-group your-resource-group-name --template-file azuredeploy.json --parameters azuredeploy.parameters.json
    ```

   Replace `your-resource-group-name` with the name of your Azure resource group.
