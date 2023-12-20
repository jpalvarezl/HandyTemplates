@description('Name of the OpenAI account.')
param name string

@description('Location for all resources.')
param location string

@description('ChatGPT model to be used')
param chatGPTModel object = {
  name: 'gpt-35-turbo-1106'
  model: {
    format: 'OpenAI'
    name: 'gpt-35-turbo'
    version: '1106'
  }
  version: '1106'
}

@description('whisper model to be used')
param whisperModel object = {
  name: 'whisper'
  model: {
    format: 'OpenAI'
    name: 'whisper'
    version: '1'
  }
}

@allowed([
  'S0'
])
param sku string

@description('CognitiveService account type. For more details: ')
param kind string = 'OpenAI'

param deployments array = [
  chatGPTModel
  // whisperModel // Find a nice overlapping region for all the resources. Whisper is not available in westus
]

resource azureOpenAIAccount 'Microsoft.CognitiveServices/accounts@2023-10-01-preview' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  kind: kind
}

resource azureOpenAIDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-10-01-preview' = [for deployment in deployments: {
  parent: azureOpenAIAccount
  name: deployment.name
  properties: {
    model: deployment.model
  }
  sku: {
    name: 'Standard'
    capacity: 20
  }
}]
