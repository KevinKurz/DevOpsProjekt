param location string = resourceGroup().location 

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'jkdsnfkdsnds'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: false
  }
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${storageAccount.name}/default/jhzz'
  dependsOn: [
    storageAccount
  ]
}

