// global Variables
@description('The Azure region in which all resources should be deployed.')
param location string = resourceGroup().location


// Storage Variables
param storageAccountName string = 'SuperduperStorage3'

@description('The SKU to use for the Storage Account.')
param storageAccountSkuName string = 'Standard_LRS'

@description('Branch of the repository for deployment.')
param repositoryBranch string  = 'main'


// Hub Variables
@description('Define the iotHub name.')
param iotHubName string = 'SuperDuperIoTHub3'

@description('The SKU to use for the IoT Hub.')
param skuName string = 'S1'

@description('The number of IoT Hub units.')
param skuUnits int = 1

@description('Define the id of the storage account.')
param storageAccountID string 

@description('Define the name of the container.')
param storageContainerName string


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

// Source Control Integration
resource srcControls 'Microsoft.Devices/IotHubs/sourcecontrols@2023-01-01' = {
  parent: IoTHub
  name: 'hub'
  properties: {
    repoUrl: 'https://github.com/KevinKurz/DevOpsProjekt'
    branch: repositoryBranch
    isManualIntegration: true
  }
}
