param storageAccountName string = 'blobStorageNameeeeh' // Hier kannst du den Namen deines Blob Storage Accounts angeben

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: 'westeurope' // Hier kannst du die gewünschte Azure-Region angeben
  sku: {
    name: 'Standard_LRS' // Hier kannst du die gewünschte SKU für den Blob Storage Account wählen
  }
  kind: 'StorageV2'
}

resource staticWebsite 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name: '${storageAccount.name}/default' // Hier wird der Standard-Container für die statische Webseite erstellt
  properties: {
    cors: []
    defaultServiceVersion: '2020-06-12'
    isVersioningEnabled: true
    deleteRetentionPolicy: {
      enabled: true
      days: 7 // Hier kannst du festlegen, wie lange gelöschte Blobs aufbewahrt werden sollen
    }
  }
}

output staticWebsiteUrl string = 'storageAccount.primaryEndpoints.blob' // Hier wird die URL des Blob Storage Accounts ausgegeben

