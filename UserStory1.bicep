param location string = resourceGroup().location

resource symbolicname 'Microsoft.Web/staticSites@2023-01-01'= {
  name: 'dsadadadsWebSite'
  location: location
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  sku: {
    capabilities: [
      {
        name: 'string'
        reason: 'string'
        value: 'string'
      }
    ]
  }
}
