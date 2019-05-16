"
I represent an implementation of a BasicComponent.
I am a component implementation because I have trait ComponentImpl.
"
Class {
	#name : #MolBasicTraitComponentImpl,
	#superclass : #Object,
	#traits : 'MolComponentImpl + MolBasicComponent',
	#classTraits : 'MolComponentImpl classTrait + MolBasicComponent classTrait',
	#instVars : [
		'myComponentConnectorVariable',
		'myNameVariable'
	],
	#category : #'Molecule-Tests-Services Events Parameters Resources'
}

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> componentConnector [

	^ myComponentConnectorVariable 
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> componentConnector: aConnector [

	myComponentConnectorVariable := aConnector
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> componentName [

	^ myNameVariable 
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> componentName: aName [

	myNameVariable := aName
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> eventNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> eventSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> eventsNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> eventsSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'component connecting' }
MolBasicTraitComponentImpl >> forEvents: anEventTrait removeProducer: aProducer [

	| producers |
	producers := self eventsSubscribers at: anEventTrait.
	producers isArray  
		ifTrue: [producers remove: aProducer ifAbsent:[nil]]
		ifFalse: [self eventsSubscribers removeKey: anEventTrait ifAbsent:[nil]]
]

{ #category : #'component connecting' }
MolBasicTraitComponentImpl >> forEvents: anEventTrait useAllProducers: aProducerList [

	self eventsSubscribers at: anEventTrait put: aProducerList
]

{ #category : #'component connecting' }
MolBasicTraitComponentImpl >> forEvents: anEventTrait useProducer: aProducer [

	(anEventTrait traits includes: MolComponentEvents)
		ifTrue: [self eventsSubscribers at: anEventTrait put: aProducer]
		ifFalse: [ MolUtils log: self printString, '>forEvent:useProducer: try to link a non event trait for an event ' ]
]

{ #category : #'component connecting' }
MolBasicTraitComponentImpl >> forServices: aServiceTrait useProvider: aServiceProvider [

	(aServiceTrait traits includes: MolComponentServices)
		ifTrue: [self servicesProviders at: aServiceTrait put: aServiceProvider]
		ifFalse: [ MolUtils log: self printString, '>forService:useProvider: try to link a non services trait for services ' ]
]

{ #category : #'private component accessing' }
MolBasicTraitComponentImpl >> servicesProviders [

	^ self componentConnector servicesProviders
]
