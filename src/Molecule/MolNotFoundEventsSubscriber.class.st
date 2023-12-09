"
I am used when an events subscriber is not found.
"
Class {
	#name : #MolNotFoundEventsSubscriber,
	#superclass : #MolNotFoundInterface,
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #testing }
MolNotFoundEventsSubscriber >> isFoundEventsSubscriber [

	^ false
]

{ #category : #testing }
MolNotFoundEventsSubscriber >> isNotFoundEventsSubscriber [

	^ self isFoundEventsSubscriber not
]
