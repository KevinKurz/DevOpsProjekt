// --- Parameters
@description('''
Define the Storage Account name
restrictions:
- Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only.
- Your storage account name must be unique within Azure. No two storage accounts can have the same name.
''')
@minLength(3)
@maxLength(24)
param storageAccountName string = 'SuperduperStorage3'

@description('The Azure region in which all resources should be deployed.')
param location string = resourceGroup().location

// --- Variables
@description('The SKU to use for the Storage Account.')
param storageAccountSkuName string = 'Standard_LRS'

// --- Resources
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2' 
}

output id string = storageAccount.id
