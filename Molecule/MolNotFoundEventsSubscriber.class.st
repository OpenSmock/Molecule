"
I am used when an events subscriber is not found.
"
Class {
	#name : #MolNotFoundEventsSubscriber,
	#superclass : #Object,
	#instVars : [
		'interface',
		'name'
	],
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #'reflective operations' }
MolNotFoundEventsSubscriber >> doesNotUnderstand: aMessage [ 
	MolUtils log: 'Message ', aMessage selector, ' of ', interface printString, ' sended to interface named ', (name ifNil:['[nil]']).
	^nil
]

{ #category : #accessing }
MolNotFoundEventsSubscriber >> interface: anInterface name: aName [ 
	interface := anInterface.
	name := aName
]

{ #category : #accessing }
MolNotFoundEventsSubscriber >> isNotFoundEventsSubscriber [
	^true
]
