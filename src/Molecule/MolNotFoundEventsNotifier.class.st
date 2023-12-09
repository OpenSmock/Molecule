"
I am used when an events notifier is not found.
"
Class {
	#name : #MolNotFoundEventsNotifier,
	#superclass : #Object,
	#instVars : [
		'interface',
		'name'
	],
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #'reflective operations' }
MolNotFoundEventsNotifier >> doesNotUnderstand: aMessage [ 
	MolUtils log: 'Message ', aMessage selector, ' of ', interface printString, ' sended to interface named ', (name ifNil:['[nil]']).
	^nil
]

{ #category : #accessing }
MolNotFoundEventsNotifier >> interface: anInterface name: aName [ 
	interface := anInterface.
	name := aName
]

{ #category : #testing }
MolNotFoundEventsNotifier >> isFoundEventsNotifier [

	^ false
]

{ #category : #testing }
MolNotFoundEventsNotifier >> isNotFoundEventsNotifier [

	^ self isFoundEventsNotifier not
]
