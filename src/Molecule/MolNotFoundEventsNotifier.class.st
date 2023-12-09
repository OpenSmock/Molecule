"
I am used when an events notifier is not found.
"
Class {
	#name : #MolNotFoundEventsNotifier,
	#superclass : #MolNotFoundInterface,
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #testing }
MolNotFoundEventsNotifier >> isFoundEventsNotifier [

	^ false
]

{ #category : #testing }
MolNotFoundEventsNotifier >> isNotFoundEventsNotifier [

	^ self isFoundEventsNotifier not
]
