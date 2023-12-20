// Keep an eye on supported regions: https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models?source=recommendations
@description('Location for all resources.')
param location string = 'westus'//resourceGroup().location

@description('OpenAI account name')
param openAIName string = 'aoai-account-name-${uniqueString(resourceGroup().id)}'

@allowed([
  'S0'
])
param sku string = 'S0'

module openAI 'modules/openai.bicep' = {
  name: 'openAI'
  params: {
    name: openAIName
    sku: sku
    location: location
  }
}

// module cognitiveSearch 'modules/cognitive_search.bicep' = {
//   name: 'cognitiveSearch'
//   params: {
//     location: location
//   }
// }

// module cosmoDB 'modules/cosmo_db.bicep' = {
//   name: 'cosmoDB'
//   params: {
//     location: location
//     containerName: 'azure_openai_test_cosmo_db_container'
//     databaseName: 'azure_openai_test_cosmo_db_database'
//   }
// }
