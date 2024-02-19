@description('Location of the resources')
param location string

@description('Tags for the storage account')
param tags object = {}

@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@minLength(3)
@maxLength(24)
@description('Name of the audit storage account')
param auditStorageAccountName string

@description('The name of the audit storage account')
param deployAuditStorageAccount bool = true 

@description('Deploy audit storage account containers option')
param deployAuditStorageAccountContainer bool = true

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account sku')
param storageAccountSku string 

var auditStorageAccountContainers = [
  'data'
  'logs'
]

module storageAccount 'modules/storage-account.bicep' = {
  name: 'deploy${storageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}

module auditStorageAccount 'modules/storage-account.bicep' = if (deployAuditStorageAccount){
  name: 'deploy${auditStorageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: auditStorageAccountName
    storageAccountSku: storageAccountSku
    containerNames: deployAuditStorageAccountContainer ? auditStorageAccountContainers : []
  }
}

var storageBlobDataReaderId = '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'

var storageAccountNames = deployAuditStorageAccount ? [
  // Implicit dependencies recommended if its a module the specify .outputs
  // if its a resource the directly specify .name because .name in module will
  // resolve to the name of the module deployment not the actual resource name 
  storageAccount.outputs.storageAccountName
  auditStorageAccount.outputs.storageAccountName
] : [
  storageAccount.outputs.storageAccountName
]

module roleAssignments 'modules/storage-account-role-assignment.bicep' = {
  name: 'deploy-role-assignments'
  params: {
    adGroupId: ''
    roleAssignmentId: storageBlobDataReaderId
    storageAccountNames: storageAccountNames 
  }
}

// module roleAssignments 'modules/storage-account-role-assignment.bicep' = {
//   name: 'deploy-role-assignments'
//   params: {
//     adGroupId: ''
//     roleAssignmentId: storageBlobDataReaderId
//     storageAccountNames: [
//       // Implicit dependencies recommended if its a module the specify .outputs
//       // if its a resource the directly specify .name because .name in module will
//       // resolve to the name of the module deployment not the actual resource name 
//       storageAccount.outputs.storageAccountName
//       auditStorageAccount.outputs.storageAccountName
//     ]
//   }
//   // Explicit dependencies not recommended
//   // dependsOn: [
//   //   storageAccount
//   //   auditStorageAccount
//   // ]
// }

output storageAccountName string = storageAccount.outputs.storageAccountName
output storageAccountId string = storageAccount.outputs.storageAccountId
output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
 