"
I am used when a parameters provider is not found.
"
Class {
	#name : #MolNotFoundParametersProvider,
	#superclass : #Object,
	#instVars : [
		'interface',
		'name'
	],
	#category : 'Molecule-Exceptions-NotFound'
}

{ #category : #'reflective operations' }
MolNotFoundParametersProvider >> doesNotUnderstand: aMessage [ 
	MolUtils log: 'Message ', aMessage selector, ' of ', interface printString, ' sended to interface named ', (name ifNil:['[nil]']).
	^nil
]

{ #category : #accessing }
MolNotFoundParametersProvider >> interface: anInterface name: aName [ 
	interface := anInterface.
	name := aName
]

{ #category : #accessing }
MolNotFoundParametersProvider >> isNotFoundParameters [
	^true
]
