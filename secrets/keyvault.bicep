@description('''
The key vault name. 
This key vault will be used to store deployment secrets to access the data-plane resources.
''')
param name string = 'aoai-tests-keyvault'

@description('Key vault location.')
param location string = resourceGroup().location

@description('Subscription tenant id.')
param tenantId string = subscription().tenantId

@description('''
Use the object id of your service principal. This could be an app registration in MS Entra, for example.
''')
param objectId string

@description('Key vault sku.')
param sku object = {
  family: 'A'
  name: 'standard'
}

resource AzureOpenAITestKeyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: name
  location: location
  properties: {
    sku: sku
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: objectId
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
        }
      }
    ]
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
    // vaultUri: 'https://${name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

output keyVaultName string = AzureOpenAITestKeyVault.name
