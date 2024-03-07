@minLength(3)
@maxLength(24)
param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
 
resource exampleStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind:'StorageV2'
}
 
