"
I am responsable for trigger events.
"
Class {
	#name : 'MolEventNotifier',
	#superclass : 'Object',
	#instVars : [
		'interface',
		'originator',
		'isActive'
	],
	#category : 'Molecule-Core',
	#package : 'Molecule',
	#tag : 'Core'
}

{ #category : 'constructor' }
MolEventNotifier class >> interface: aMolUsedEvents originator: aComponent [
	^ self new interface: aMolUsedEvents; originator: aComponent
]

{ #category : 'actions' }
MolEventNotifier >> activate [
	isActive := true
]

{ #category : 'actions' }
MolEventNotifier >> deactivate [
	isActive := false
]

{ #category : 'reflective operations' }
MolEventNotifier >> doesNotUnderstand: aMessage [
	"Event message is called by a Notifier, the message not exists in MolEventNotifier so the system called doesNotUnderstand: message. Check if the event message is known by the event interface and trigger the event."
	| isEventExist |
	interface ifNil:[ ^ super doesNotUnderstand: aMessage ].
	originator ifNil:[ 
		MolUtils log: 'Originator not defined for event: ' , aMessage selector. 
		^ self
	].
	isEventExist := interface includesSelector: aMessage selector.

	isEventExist	
		ifTrue: [
			isActive 
				ifTrue: [ 
					MolUtils log: originator printString , ' send event: ' , aMessage selector.
					originator triggerEvent: aMessage selector withArguments: aMessage arguments.
				] ifFalse: [ 
					MolUtils log: 'An inactive component: ', originator printString , ' send event: ' , aMessage selector. 				].
			^ self.
		] ifFalse: [ 
			MolUtils log: originator printString , ' send an undefined event: ' , aMessage selector.
		].
	
	^ super doesNotUnderstand: aMessage
		
		
	
]

{ #category : 'initialize-release' }
MolEventNotifier >> initialize [
	super initialize.
	self deactivate.
]

{ #category : 'accessing' }
MolEventNotifier >> interface [
	^ interface
]

{ #category : 'accessing' }
MolEventNotifier >> interface: anInterface [
	interface := anInterface
]

{ #category : 'accessing' }
MolEventNotifier >> isActive [
	^ isActive
]

{ #category : 'initialize-release' }
MolEventNotifier >> isNotFoundEventsNotifier [ 
	^false
]

{ #category : 'accessing' }
MolEventNotifier >> originator [
	^ originator
]

{ #category : 'accessing' }
MolEventNotifier >> originator: aComponent [
	originator := aComponent
]

{ #category : 'initialize-release' }
MolEventNotifier >> release [
	self deactivate.
	interface := nil.
	originator := nil.
	super release.
]
