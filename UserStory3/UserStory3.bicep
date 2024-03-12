// Global Variables
@description('The Azure region in which all resources should be deployed.')
param location string = resourceGroup().location


// Storage Variables
param storageAccountName string = 'SuperDuperStorage3'

@description('The SKU to use for the Storage Account.')
param storageAccountSkuName string = 'Standard_LRS'

@description('Branch of the repository for deployment.')
param repositoryBranch string  = 'main'


// Hub Variables
@description('Define the IotHub name.')
param iotHubName string = 'SuperDuperIoTHub3'

@description('The SKU to use for the IoT Hub.')
param skuName string = 'S1'

@description('The number of IoT Hub units.')
param skuUnits int = 1

@description('Define the id of the storage account.')
param storageAccountID string 

@description('Define the name of the container.')
param storageContainerName string


//Web App Variables
@description('The text to replace the default subtitle with.')
param textToReplaceSubtitleWith string = 'This is my default subtitle text. Boring, right?'


// --- Variables
var storageEndpoint = '${storageAccountName}StorageEndpont'
var storageAccountKey = listKeys(storageAccountID, '2024-03-11').keys[0].value


// --- Storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2' 
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
            connectionString: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccountKey}'
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
  name: 'AppServiceplanUserStory3'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

// WebAppCreation
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'superuniqename'
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
