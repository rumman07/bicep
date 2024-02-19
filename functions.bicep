@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

// String Funcrions 
var myFirstString = 'mystring${storageAccountName}'
var upperCase = toUpper(myFirstString)
var lowerCase = toLower(myFirstString)
var trimmed = trim(' spaces ')
var sub = substring(trimmed, 0, 2)

// Data conversion 
var myBool = bool('true')
var myInteger = int('10')
var myString = string(10)

// Arrays 
var myArray = [
  'myString'
  'myAnotherString'
]

var mySecondArray = [
  'myString'
  'myOtherString'
]

// Array functions 
var firstElement = first(myArray)
var lastElement = last(myArray)
var isArrayEmpty = empty(myArray)

var splitString = split('header1,header2,header3',',')
var combinedArray = concat(myArray, mySecondArray)
var unionArray = union(myArray, mySecondArray)

// Scope functions
var resourceGroupNames = resourceGroup().name
var subscriptionId = subscription().id

var storageAccountKey = storageAccount.listKeys().keys[0]

// Loading files 
var loadedJson = loadJsonContent('example.json')
var jsonContent = loadedJson.storageAccounts[0].name

var loadedYaml = loadYamlContent('example.yml')
var yamlContent = loadedYaml.address




