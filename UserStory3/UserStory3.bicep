// Global Variables
@description('The Azure region in which all resources should be deployed.')
param location string = resourceGroup().location


// Storage Variables
@description('Branch of the repository for deployment.')
param repositoryBranch string  = 'main'

param projectName string = 'userstory3'

@description('The SKU to use for the IoT Hub.')
param skuName string = 'S1'

@description('The number of IoT Hub units.')
param skuUnits int = 1


//Web App Variables
@description('The text to replace the default subtitle with.')
param textToReplaceSubtitleWith string = 'This is my default subtitle text. Boring, right?'


// // --- Variables for connectionstring
var iotHubName = '${projectName}Hub${uniqueString(resourceGroup().id)}'
var storageAccountName = '${toLower(projectName)}${uniqueString(resourceGroup().id)}'
var storageEndpoint = '${projectName}StorageEndpont'
var storageContainerName = '${toLower(projectName)}results'


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}


resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  name: '${storageAccountName}/default/${storageContainerName}'
  properties: {
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccount
  ]
}


// --- IoT hub
resource IoTHub 'Microsoft.Devices/IotHubs@2023-06-30' = {
  name: iotHubName
  location: location
  sku: {
    name: skuName
    capacity: skuUnits
  }  
  properties: {
    eventHubEndpoints: {
      events: {
        retentionTimeInDays: 1
        partitionCount: 4
      }
    }
    routing: {
      endpoints: {
        storageContainers: [
          {
            connectionString: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
            containerName: storageContainerName
            fileNameFormat: '{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}'
            batchFrequencyInSeconds: 100
            maxChunkSizeInBytes: 104857600
            encoding: 'JSON'
            name: storageEndpoint
          }
        ]
      }
      routes: [
        {
          name: 'ContosoStorageRoute'
          source: 'DeviceMessages'
          condition: 'level="storage"'
          endpointNames: [
            storageEndpoint
          ]
          isEnabled: true
        }
      ]
      fallbackRoute: {
        name: '$fallback'
        source: 'DeviceMessages'
        condition: 'true'
        endpointNames: [
          'events'
        ]
        isEnabled: true
      }
    }    
  }
}


//App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-userstory3'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}


// WebAppCreation
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-userstory3'
  location: location
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
