@description('''
The Azure OpenAI account in which the OpenAI model will be deployed. It should follow the following structure:
{
  name: string
  location: string
  sku: {
    name: string
  }
  kind: string
}
''')
param openAIAccount object

@description('''
The deployment is expected to have the following structure:
{
  name: string
  model: {
    format: string
    name: string
    version: string
  }
  sku: {
    name: string
    capacity: number
  }
}
''')
param openAIDeployment object

resource azureOpenAIAccount 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' = {
  name: openAIAccount.name
  location: openAIAccount.location
  sku: openAIAccount.sku
  kind: openAIAccount.kind
}

resource azureOpenAIDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-10-01-preview' = {
  parent: azureOpenAIAccount
  name: openAIDeployment.name
  properties: {
    model: openAIDeployment.model
  }
  sku: openAIDeployment.sku
}
