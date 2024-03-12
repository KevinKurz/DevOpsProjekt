// IoTHub Variables
@description('Define the iotHub name.')
param iotHubName string = 'SuperDuperIotHub2'

@description('The Azure region in which all resources should be deployed.')
param location string = resourceGroup().location

@description('The SKU to use for the IoT Hub.')
param skuName string = 'S1'

@description('The number of IoT Hub units.')
param skuUnits int = 1


//Source Controll Integration Variables
@description('Branch of the repository for deployment.')
param repositoryBranch string  = 'main'


//Web App Variables
@description('The text to replace the default subtitle with.')
param textToReplaceSubtitleWith string = 'This is my default subtitle text. Boring, right?'


//IoT Hub Creation
resource IoTHub 'Microsoft.Devices/IotHubs@2023-06-30' = {
  name: iotHubName
  location: location
  sku: {
    name: skuName
    capacity: skuUnits
  }  
}


// WebAppCreation
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: 'superuniqename'
  location: location
  properties: {
    serverFarmId: IoTHub.id
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
