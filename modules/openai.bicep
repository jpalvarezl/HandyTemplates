import { accountConfig, deploymentConfig } from '../types/aoai_resource.bicep'

@description('An OpenAI Azure account which into which deployments can be added.')
param openAIAccount accountConfig

@description('An OpenAI deployment, such as gpt-4, whisper, etc.')
param openAIDeployment deploymentConfig

resource azureOpenAIAccount 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' = {
  name: openAIAccount.name
  location: openAIAccount.location
  sku: openAIAccount.sku
  kind: openAIAccount.kind
  properties: {
    customSubDomainName: openAIAccount.name
    publicNetworkAccess: 'Enabled'
  }
}

resource azureOpenAIDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-10-01-preview' = {
  parent: azureOpenAIAccount
  name: openAIDeployment.name
  properties: {
    model: openAIDeployment.model
    raiPolicyName: 'Microsoft.Default'
  }
  sku: openAIDeployment.sku
}

module azureOpenAIKeySecret 'key_vault_store.bicep' = {
  name: '${azureOpenAIDeployment.name}-openai-endpoint'
  params: {
    name: '${toUpper(replace(azureOpenAIDeployment.name, '-', '_')) }_SECRET_KEY'
    value: azureOpenAIAccount.listKeys().key1
  }
}

module azureOpenAIEndpointSecret 'key_vault_store.bicep' = {
  name: '${azureOpenAIDeployment.name}-openai-key'
  params: {
    name: '${toUpper(replace(azureOpenAIDeployment.name, '-', '_')) }_ENDPOINT'
    value: azureOpenAIAccount.listKeys().key1
  }
}
