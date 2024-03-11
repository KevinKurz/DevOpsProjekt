@description('Define the iotHub name.')
param iotHubName string = 'SuperDuperIotHub2'

@description('The Azure region in which all resources should be deployed.')
param location string = resourceGroup().location

@description('The SKU to use for the IoT Hub.')
param skuName string = 'S1'

@description('The number of IoT Hub units.')
param skuUnits int = 1

@description('Branch of the repository for deployment.')
param repositoryBranch string  = 'main'

resource IoTHub 'Microsoft.Devices/IotHubs@2023-06-30' = {
  name: iotHubName
  location: location
  sku: {
    name: skuName
    capacity: skuUnits
  }  
}

// Source Control Integration
resource srcControls 'Microsoft.Devices/IotHubs/sourcecontrols@2023-01-01' = {
  parent: IoTHub
  name: 'web'
  properties: {
    repoUrl: 'https://github.com/KevinKurz/DevOpsProjekt'
    branch: repositoryBranch
    isManualIntegration: true
  }
}
