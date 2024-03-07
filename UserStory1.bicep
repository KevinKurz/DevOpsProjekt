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
    repoUrl: 'string'
    branch: repositoryBranch
    isManualIntegration: true
  }
}
