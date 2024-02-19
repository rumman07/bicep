@description('Location for the resources')
param location string = 'westus'

@description('Tags for the storage account')
param tags object = {}

@minLength(3)
@maxLength(24)
@description('The name of the storage account')
param storageAccountName string 

@description('Name of the SKU')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string

@description('Support HTTPS traffic only')
param supportHttpsTrafficOnly bool = true

@description('Names of the containers to deploy')
param containerNames array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: supportHttpsTrafficOnly
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = if (!empty(containerNames)) {
  name: 'default'
  parent:storageAccount
}

// resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
//   name: 'data'
//   parent: blobServices
//   properties: {
//     publicAccess: 'None'
//   }
// }

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for containerName in containerNames: {
  name: containerName
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}]


output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
