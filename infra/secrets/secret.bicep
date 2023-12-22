@secure()
@description('Value of the secret to be stored')
param value string

@secure()
@description('Name of the key for the secret to be stored')
param name string

resource aoaiKeyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: 'aoai-tests-keyvault'
}

resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: aoaiKeyVault
  name: name
  properties: {
    value: value
  }
}
