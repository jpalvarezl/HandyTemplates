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

// we re-purpose the secret name for the name of the deployment for their respective resources
var endpointSecretName = '${azureOpenAIDeployment.name}-openai-endpoint'
var keySecretName = '${azureOpenAIDeployment.name}-openai-key'

module azureOpenAIKeySecret '../secrets/secret.bicep' = {
  name: keySecretName
  params: {
    name: keySecretName
    value: azureOpenAIAccount.listKeys().key1
  }
}

module azureOpenAIEndpointSecret '../secrets/secret.bicep' = {
  name: endpointSecretName
  params: {
    name: endpointSecretName
    value: azureOpenAIAccount.properties.endpoint
  }
}
