import { azureOpenAIResourceConfig } from 'types/aoai_resource_config.bicep'

// the account field 'kind' is a value obtained from there: // CognitiveService account type. For more details: https://learn.microsoft.com/en-us/azure/ai-services/create-account-bicep?tabs=CLI#azure-openai
@description('OpenAI account kind to be used')
param openAIAccountKind string = 'OpenAI'

@description('OpenAI account SKU to be used')
param openAIAccountSku object = {
  name: 's0'
}

@description('Azure OppenAI deployment SKU')
param openAIDeploymentSku object = {
  name: 'Standard'
  capacity: 1
}

@description('Azure region where the text model account and cognitive search will be created')
param chatGPTLocation string  = 'swedencentral'

// for model region availability visit:
// https://learn.microsoft.com/en-us/azure/ai-services/openai/concepts/models?source=recommendations
@description('ChatGPT model to be used')
param chatGPTModel azureOpenAIResourceConfig = {
  account: {
    name: 'chat-completions-testing-account'
    location: chatGPTLocation
    kind: openAIAccountKind
    sku: openAIAccountSku
  }  
  deployment: {
    name: 'gpt-35-turbo-1106'
    model: {
      format: 'OpenAI'
      name: 'gpt-35-turbo'
      version: '1106'
    }
    sku: openAIDeploymentSku
  }
}

@description('whisper model to be used')
param whisperModel azureOpenAIResourceConfig = {
  account: {
    name: 'audio-testing-account'
    location: 'eastus2'
    kind: openAIAccountKind
    sku: openAIAccountSku
  }
  deployment: {
    name: 'whisper-01'
    model: {
      format: 'OpenAI'
      name: 'whisper'
      version: '1'
    }
    sku: openAIDeploymentSku
  }
}

param openAIDeployments array = [
  chatGPTModel
  whisperModel
]

// module openAIResource 'modules/openai.bicep' = [for openAIDeployment in openAIDeployments:{
//   // If you navigate to Azure portal, "name" will be the deployment name
//   name: '${openAIDeployment.account.name}-${openAIDeployment.deployment.name}'
//   params: {
//     openAIAccount: openAIDeployment.account
//     openAIDeployment: openAIDeployment.deployment
//   }
// }]

module cognitiveSearch 'modules/cognitive_search.bicep' = {
  name: 'cognitive-search'
  params: {
    location: chatGPTLocation
  }
}
