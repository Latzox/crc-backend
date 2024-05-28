param appName string = 'crcbackend'
param environment string = 'dev'
param instance int = 003
param location string = resourceGroup().location
param COSMOS_TABLEAPI_CONNECTION_STRING string

resource sa 'Microsoft.Storage/storageAccounts@2023-04-01' = {
  name: 'sa${appName}${environment}${instance}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

resource asp 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'asp-${appName}-${environment}-${instance}'
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
  properties: {
    reserved: true
  }
}

resource fa 'Microsoft.Web/sites@2023-12-01' = {
  name: 'fa-${appName}-${environment}-${instance}'
  location: location
  kind: 'functionapp,linux'
  properties: {
    reserved: true
    serverFarmId: asp.id
    siteConfig: {
      linuxFxVersion: 'Python|3.11'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${sa.name};EndpointSuffix=core.windows.net;AccountKey=${sa.listKeys().keys[0].value}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'COSMOS_TABLEAPI_CONNECTION_STRING'
          value: '${COSMOS_TABLEAPI_CONNECTION_STRING}'
        }
      ]
    }
    httpsOnly: true
  }
}

