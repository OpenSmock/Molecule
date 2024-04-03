"
I am used when an events notifier is not found.
"
Class {
	#name : 'MolNotFoundEventsNotifier',
	#superclass : 'MolNotFoundInterface',
	#traits : 'TMolEventsNotifier',
	#classTraits : 'TMolEventsNotifier classTrait',
	#category : 'Molecule-Exceptions-NotFound',
	#package : 'Molecule',
	#tag : 'Exceptions-NotFound'
}

{ #category : 'testing' }
MolNotFoundEventsNotifier >> isFoundEventsNotifier [

	^ false
]
