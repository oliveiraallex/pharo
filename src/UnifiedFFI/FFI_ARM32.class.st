Class {
	#name : #'FFI_ARM32',
	#superclass : #'FFI_i386',
	#category : #'UnifiedFFI-Architecture'
}

{ #category : #testing }
FFI_ARM32 class >> isActive [
	^ Smalltalk vm wordSize = 4 and: [ Smalltalk vm isArm ]
]

{ #category : #callback }
FFI_ARM32 >> newCallbackArgumentReaderForCallback: aCallback inContext: aCallbackContext [

	^ FFIArm32CallbackArgumentReader 
		forCallback: aCallback
		inContext: aCallbackContext
]

{ #category : #callback }
FFI_ARM32 >> returnSingleFloatsAsDoubles [
	^ false
]
