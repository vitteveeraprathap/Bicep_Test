param kvName string
param location string = resourceGroup().location
param skuName string = 'standard'
param enableSoftDelete bool = true
param enablePurgeProtection bool = false

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: kvName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: { family: 'A', name: skuName }
    accessPolicies: []
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: enablePurgeProtection
  }
}

output keyVaultName string = kv.name
