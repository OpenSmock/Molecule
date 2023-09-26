"
I am used when a service provider is not found.
"
Class {
	#name : 'MolNotFoundServicesProvider',
	#superclass : 'Object',
	#instVars : [
		'interface',
		'name'
	],
	#category : 'Molecule-Exceptions-NotFound',
	#package : 'Molecule',
	#tag : 'Exceptions-NotFound'
}

{ #category : 'reflective operations' }
MolNotFoundServicesProvider >> doesNotUnderstand: aMessage [ 
	MolUtils log: 'Message ', aMessage selector, ' of ', interface printString, ' sended to interface named ', (name ifNil:['[nil]']).
	^nil
]

{ #category : 'accessing' }
MolNotFoundServicesProvider >> interface: anInterface name: aName [ 
	interface := anInterface.
	name := aName
]

{ #category : 'accessing' }
MolNotFoundServicesProvider >> isNotFoundServices [
	^true
]
