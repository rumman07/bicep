var myFirstBool = true
var mySecondBool = false

var myFirstArray = [
  'myString'
]

var myObject = {
  myString: null
  mySecondString: 'myString'
}

var and = myFirstBool && mySecondBool

var bothNot = !myFirstBool && !mySecondBool

var or = myFirstBool || mySecondBool

//Colesace returns the first value which is not null.
var col = myObject.myString ?? myObject.mySecondString ?? 'myothervalue'

var lengthOfArray = length(myFirstArray)

var isArrayAbove10 = length(myFirstArray) > 10

var isEmpty = empty(myFirstArray)
