# Userstory 1

As a User I want to be able to access the application on all my devices without the need of an installation.
Therefore, I would use my browser and we need to create a resource to host a website.

## Task 1: Find a Resource to host a website on it

In Visual Studio Code you need to install the extension "Azure Storage". This extension integrates Azure Storage management functionality. The extension is able to deploy a static website to Azure Storage.
Storage typewise you go with an Azure Blob Storage.

## Task 2: Create a Resource Template for it

param webAccountName string = 'SuperduperService'

@description('Azure resource deployment location.')
param location string = resourceGroup().location

@description('The text to replace the default subtitle with.')
param textToReplaceSubtitleWith string = 'This is my default subtitle text. Boring, right?'

@description('Branch of the repository for deployment.')
param repositoryBranch string  = 'main'

// AppServicePlan creation
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: webAccountName
  location: location
  properties: {
    reserved: false
  }
  sku: {
    name: 'F1'
  }
  kind: 'app'
}

// WebAppCreation
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'superuniqename'
  location: location
  kind: 'string'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'TEXT_TO_REPLACE_SUBTITLE_WITH' // This value needs to match the name of the environment variable in the application code
          value: textToReplaceSubtitleWith
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT' // Build the application during deployment
          value: 'true'
        }
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION' // Set the default node version
          value: '~20'
        }
      ]
      publicNetworkAccess: 'Enabled'
    }
  }
}

// Source Control Integration
resource srcControls 'Microsoft.Web/sites/sourcecontrols@2023-01-01' = {
  parent: appService
  name: 'web'
  properties: {
    repoUrl: 'https://github.com/KevinKurz/DevOpsProjekt'
    branch: repositoryBranch
    isManualIntegration: true
  }
}

## Task 3: Create Parameter Files for dev, test and prod resources

## Task 4: Write a PowerShell Script to deploy all stages. You want to only deploy one stage per execution (./createWebApp.ps1 -Environment dev)

## Task 5: short documentation why you choose the resource and what other options you found. Compare the different Features
