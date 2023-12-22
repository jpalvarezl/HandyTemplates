@description('Service name must only contain lowercase letters, digits or dashes, cannot use dash as the first two or last one characters, cannot contain consecutive dashes, and is limited between 2 and 60 characters in length.')
@minLength(2)
@maxLength(60)
param name string = 'cog-search-testing-${uniqueString(resourceGroup().id)}'

@description('The pricing tier of the search service you want to create (for example, basic or standard).')
param sku object = {
  name: 'standard'
}


@description('Location for all resources.')
param location string = resourceGroup().location

resource cognitiveSearch 'Microsoft.Search/searchServices@2023-11-01' = {
  name: name
  location: location
  sku: sku
  properties: {
    replicaCount: 1
    partitionCount: 1
    hostingMode: 'default'
    publicNetworkAccess: 'enabled'
    disableLocalAuth: false
    semanticSearch: 'disabled'
    authOptions: {
      apiKeyOnly: {}
    }
  }
}

// we re-purpose the secret name for the name of the deployment for their respective resources
var keySecretName = 'cognitive-search-primary-key'
var endpointSecretName = 'cognitive-search-endpoint'

module cognitiveSearchPrimaryKeySecret '../secrets/secret.bicep' = {
  name: keySecretName
  params: {
    name: keySecretName
    value: cognitiveSearch.listAdminKeys().primaryKey
  }
}

module cognitiveSearchEndpointSecret '../secrets/secret.bicep' = {
  name: endpointSecretName
  params: {
    name: endpointSecretName
    value: 'https://${cognitiveSearch.name}.search.windows.net'
  }
}
