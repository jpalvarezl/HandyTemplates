// Using experimental feature
// https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-import#import-types-variables-and-functions-preview
@export()
type azureOpenAIResourceConfig = {
  account: accountConfig
  deployment: deploymentConfig
}

@export()
type deploymentConfig = {
  name: string
  model: {
    format: string
    name: string
    version: string
  }
  sku: {
    name: string
    capacity: int
  }
}

@export()
type accountConfig = {
  name: string
  location: string
  kind: string
  sku: {
    name: string
  }
}
