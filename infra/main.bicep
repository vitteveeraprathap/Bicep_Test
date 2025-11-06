param location string = 'southeastasia'
param rgName string

param deployStorage bool = true
param deployKeyVault bool = true
param deployContainer bool = true

param storageName string = ''
param storageSku string = 'Standard_LRS'
param storageKind string = 'StorageV2'

param keyVaultName string = ''
param keyVaultSkuName string = 'standard'
param enableSoftDelete bool = true
param enablePurgeProtection bool = false

param containerName string = ''

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
  tags: { environment: 'managed' }
}

module storageMod 'modules/storage.bicep' = if (deployStorage) {
  name: 'storageDeployment'
  scope: resourceGroup(rg.name)
  params: {
    storageName: storageName
    skuName: storageSku
    kind: storageKind
    location: location
  }
}

module kvMod 'modules/keyvault.bicep' = if (deployKeyVault) {
  name: 'keyvaultDeployment'
  scope: resourceGroup(rg.name)
  params: {
    kvName: keyVaultName
    location: location
    skuName: keyVaultSkuName
    enableSoftDelete: enableSoftDelete
    enablePurgeProtection: enablePurgeProtection
  }
}

module containerMod 'modules/storageContainer.bicep' = if (deployContainer) {
  name: 'containerDeployment'
  scope: resourceGroup(rg.name)
  params: {
    storageAccountName: storageName
    containerName: containerName
  }
}

output resourceGroupName string = rg.name
