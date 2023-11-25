param location string = resourceGroup().location

module cognitiveSearch 'modules/cognitive_search.bicep' = {
  name: 'cognitiveSearch'
  params: {
    location: location
  }
}

module cosmoDB 'modules/cosmo_db.bicep' = {
  name: 'cosmoDB'
  params: {
    location: location
    containerName: 'azure_openai_test_cosmo_db_container'
    databaseName: 'azure_openai_test_cosmo_db_database'
  }
}
