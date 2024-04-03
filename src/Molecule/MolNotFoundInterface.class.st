Class {
	#name : 'MolNotFoundInterface',
	#superclass : 'Object',
	#instVars : [
		'interface',
		'name'
	],
	#category : 'Molecule-Exceptions-NotFound',
	#package : 'Molecule',
	#tag : 'Exceptions-NotFound'
}

{ #category : 'testing' }
MolNotFoundInterface class >> interface: anInterface name: aName [

	^ self new interface: anInterface; name: aName; yourself
]

{ #category : 'testing' }
MolNotFoundInterface class >> isAbstract [

	^ self = MolNotFoundInterface
]

{ #category : 'reflective operations' }
MolNotFoundInterface >> doesNotUnderstand: aMessage [
	"Return nil as a result and log the interface call for debugging"

	MolUtils log:
		'Message ' , aMessage selector , ' of ' , interface printString
		, ' sended to interface named ' , (name ifNil: [ '[nil]' ]).

	^ nil
]

{ #category : 'accessing' }
MolNotFoundInterface >> interface [

	^ interface
]

{ #category : 'accessing' }
MolNotFoundInterface >> interface: anObject [

	interface := anObject
]

{ #category : 'accessing' }
MolNotFoundInterface >> interface: anInterface name: aName [

	self interface: anInterface.
	self name: aName
]

{ #category : 'accessing' }
MolNotFoundInterface >> name [

	^ name
]

{ #category : 'accessing' }
MolNotFoundInterface >> name: anObject [

	name := anObject
]
