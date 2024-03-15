# IoT Hub & Web App Deployment Readme

This readme provides instructions for deploying Azure IoT Hub and Web App resources using the provided ARM template.

## Prerequisites

Ensure you have the following prerequisites before deploying the resources:

- Azure subscription
- Azure CLI installed
- Git installed

## Deployment Steps

Follow these steps to deploy the Azure resources:

1. Clone this repository to your local machine:

    ``` bash
    git clone https://github.com/your-repository-url.git
    ```

2. Navigate to the cloned repository directory:

    ``` bash
    cd your-repository-directory
    ```

3. Modify the parameters in the `azuredeploy.parameters.json` file according to your requirements.

4. Deploy the resources using the Azure CLI:

    ``` pwsh
    az deployment group create --resource-group your-resource-group-name --template-file azuredeploy.json --parameters azuredeploy.parameters.json
    ```

   Replace `your-resource-group-name` with the name of your Azure resource group.

## Parameters

### IoT Hub

- **iotHubName**: Name for the Azure IoT Hub.
- **location**: Azure region where the IoT Hub will be deployed.
- **skuName**: SKU to use for the IoT Hub.
- **skuUnits**: Number of IoT Hub units.

### Source Control Integration

- **repositoryBranch**: Branch of the repository for deployment.

### Web App

- **textToReplaceSubtitleWith**: Text to replace the default subtitle with in the application.

## Description

This ARM template deploys an Azure IoT Hub, an Azure App Service Plan, and an Azure Web App. It also integrates the Web App with a specified GitHub repository for source control.

## IoT Hub Template

- **Name**: `iotHubName`
- **Location**: `location`
- **SKU**: `skuName` with `skuUnits` capacity

## App Service Plan

- **Name**: `asp-userstory2`
- **Location**: `location`
- **SKU**: `F1` (Free tier)

## Web App Template

- **Name**: `app-userstory2`
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
