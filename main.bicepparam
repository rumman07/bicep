using './main.bicep'

param location = 'westus'
param tags = {
  owner: 'RankinSoft'
  env: 'dev'
  reason: 'learning'
}
param storageAccountName = 'uclbsto01'
param auditStorageAccountName = 'uclbauditsto01'
param storageAccountSku = 'Standard_LRS'
//param supportsHttpsTrafficOnly = true

