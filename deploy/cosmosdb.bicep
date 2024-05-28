param appName string = 'crcbackend'
param environment string = 'dev'
param instance int = 002
param location string = resourceGroup().location

resource cosmosdbaccount 'Microsoft.DocumentDB/databaseAccounts@2023-11-15' = {
  name: 'cda-${appName}-${environment}-${instance}'
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    databaseAccountOfferType: 'Standard'
    capabilities: [
      {
        name: 'EnableTable'
      }
      {
        name: 'EnableServerless'
      }
    ]
    
    locations: [
      {
        locationName: 'Switzerland North'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
  }
}

resource tabledb 'Microsoft.DocumentDB/databaseAccounts/tables@2016-03-31' = {
  parent: cosmosdbaccount
  name: 'visitorCounts'
  properties: {
    resource: {
      id: 'visitorCounts'
    }
    options: {
      throughput: 400
    }
  }
}

