@description('Location of the resources')
param location string

param tags object = {}

@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@minLength(3)
@maxLength(24)
@description('Name of the Audit storage account')
param auditStorageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account sku')
param storageAccountSku string

@description('Support HTTPS traffic only')
param supportsHttpsTrafficOnly bool = true

var storageAccountKind = 'StorageV2'
var storageAccountProperties = {
  minimumTlsVersion: 'TLS1_2'
  supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
}

resource uclbsto1 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountProperties
}

resource uclbauditsto 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: auditStorageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountProperties
}

output storageAccountName string = uclbsto1.name
output auditStorageAccountName string = uclbauditsto.name
output storageAccountId string = uclbsto1.id
output auditStorageAccountId string = uclbauditsto.id
output storageAccountTags object = uclbsto1.tags
output auditStorageAccountTags object = uclbauditsto.tags


