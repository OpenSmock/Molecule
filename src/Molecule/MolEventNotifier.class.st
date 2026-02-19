"
I am responsable for trigger events.
"
Class {
	#name : #MolEventNotifier,
	#superclass : #Object,
	#traits : 'TMolEventsNotifier',
	#classTraits : 'TMolEventsNotifier classTrait',
	#instVars : [
		'interface',
		'originator',
		'isActive'
	],
	#category : #'Molecule-Core'
}

{ #category : #constructor }
MolEventNotifier class >> interface: aMolUsedEvents originator: aComponent [
	^ self new interface: aMolUsedEvents; originator: aComponent
]

{ #category : #actions }
MolEventNotifier >> activate [

	isActive := true
]

{ #category : #actions }
MolEventNotifier >> deactivate [

	isActive := false
]

{ #category : #'reflective operations' }
MolEventNotifier >> doesNotUnderstand: aMessage [
	"Event message is called by a Notifier, the message not exists in MolEventNotifier so the system called doesNotUnderstand: message. Check if the event message is known by the event interface and trigger the event."

	self interface
		ifNil: [ "cannot interpret the message, return not understand"
			^ super doesNotUnderstand: aMessage ]
		ifNotNil: [
				| isEventExist |
				isEventExist := self interface includesSelector: aMessage selector.
				isEventExist
					ifFalse: [
							MolUtils log:
								self originator printString , ' send an undefined event: '
								, aMessage selector.
							"the event not exists, stop production here and return not understand"
							^ super doesNotUnderstand: aMessage ]
					ifTrue: [ self produceEvent: aMessage ] ]
]

{ #category : #initialization }
MolEventNotifier >> initialize [

	super initialize.

	self deactivate
]

{ #category : #accessing }
MolEventNotifier >> interface [

	^ interface
]

{ #category : #accessing }
MolEventNotifier >> interface: anInterface [

	interface := anInterface
]

{ #category : #accessing }
MolEventNotifier >> isActive [

	^ isActive
]

{ #category : #testing }
MolEventNotifier >> isFoundEventsNotifier [

	^ true
]

{ #category : #accessing }
MolEventNotifier >> originator [

	^ originator
]

{ #category : #accessing }
MolEventNotifier >> originator: aComponent [

	originator := aComponent
]

{ #category : #private }
MolEventNotifier >> produceEvent: aMessage [
	"Produce an event to offered components"

	"If the notifier is not active, stop production here"
	self isActive ifFalse: [ ^ self ].

	"If there is no originator, stop the production here"
	self originator ifNil: [
			MolUtils log:
				'Originator not defined for event: ' , aMessage selector.
			^ self ].

	MolUtils log:
		self originator printString , ' send event: ' , aMessage selector.

	"produce the event using object trigger mecanism"
	self originator
		triggerEvent: aMessage selector
		withArguments: aMessage arguments
]

{ #category : #dependencies }
MolEventNotifier >> release [

	self deactivate.
	originator := nil.

	super release
]
