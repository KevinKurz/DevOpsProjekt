param location string = resourceGroup().location

@description('Define the Storage Account name')
param storageAccountName string 

@description('Define the name of the container.')
param storageContainerName string 

@description('Define the iotHub name.')
param iotHubName string 

// --- Storage account
module storageAccount 'Storage3.bicep' = {
  name: 'storageAccountAux'
  params: {
    storageAccountName: storageAccountName
    storageAccountSkuName: storageContainerName
    location: location
  }
}

// --- IoT hub
module IoTHub 'IoThub3.bicep' = {
  name: 'IoTHub'
  params: {
    iotHubName: iotHubName
    location: location
    storageAccountName: storageAccountName
    storageAccountID: storageAccount.outputs.id
    storageContainerName: storageContainerName
  }
}
