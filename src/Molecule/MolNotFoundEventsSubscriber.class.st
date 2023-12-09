"
I am used when an events subscriber is not found.
"
Class {
	#name : #MolNotFoundEventsSubscriber,
	#superclass : #MolNotFoundInterface,
	#traits : 'TMolEventsSubscriber',
	#classTraits : 'TMolEventsSubscriber classTrait',
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #testing }
MolNotFoundEventsSubscriber >> isFoundEventsSubscriber [

	^ false
]
