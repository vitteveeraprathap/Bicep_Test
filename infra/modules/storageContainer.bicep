param storageAccountName string
param containerName string

resource st 'Microsoft.Storage/storageAccounts@2023-01-01' existing = { name: storageAccountName }
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'default/${containerName}'
  parent: st
  properties: { publicAccess: 'None' }
}
