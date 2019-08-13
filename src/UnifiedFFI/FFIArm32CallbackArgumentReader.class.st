Class {
	#name : #FFIArm32CallbackArgumentReader,
	#superclass : #FFIi386CallbackArgumentReader,
	#instVars : [
		'currentRegisterIndex',
		'floatOffset'
	],
	#category : #'UnifiedFFI-Callbacks'
}

{ #category : #'calculating-offsets' }
FFIArm32CallbackArgumentReader >> extractDouble [

	| type baseAddressToRead  |


	type := FFIFloat64 new.
	baseAddressToRead := callbackContext floatregargsp.

	"The doubles are always in 8 byte alignment"
	(floatOffset % 8) ~= 1 ifTrue: [ floatOffset := floatOffset + 4 ].

	extractedArguments 
		add: (type handle: baseAddressToRead at: floatOffset).

	floatOffset := floatOffset + 8.

]

{ #category : #'calculating-offsets' }
FFIArm32CallbackArgumentReader >> extractFloat [

	| type baseAddressToRead  |


	type := FFIFloat32 new.
	baseAddressToRead := callbackContext floatregargsp.

	extractedArguments 
		add: (type handle: baseAddressToRead at: floatOffset).

	floatOffset := floatOffset + 4.

]

{ #category : #'calculating-offsets' }
FFIArm32CallbackArgumentReader >> initialize [

	super initialize.
	currentRegisterIndex := 1.
	floatOffset := 1.
]

{ #category : #'calculating-offsets' }
FFIArm32CallbackArgumentReader >> nextBaseAddressFor: type [
	
	| baseAddressToRead offsetOfBaseAddress registerIndex |
	
	registerIndex := currentRegisterIndex.
	
	^ registerIndex <= 4 
		ifTrue:[ 
				"In ARM 32 the first 4 parameters came in the registers and the other in stack"
				baseAddressToRead := callbackContext intregargsp.				
				
				offsetOfBaseAddress := (registerIndex - 1) * Smalltalk wordSize + 1.
				currentRegisterIndex := registerIndex + 1.

				{ baseAddressToRead. offsetOfBaseAddress }] 

		ifFalse:[ super nextBaseAddressFor: type ].
]
