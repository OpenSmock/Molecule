"
I am a superclass of a component implementation. Notice that I use the trait ComponentImpl, and I have just two additional instance variables componentName and componentConnector.

You can create a componant implementation by using me as superclass, or directly use ComponentImpl trait. In that case, you have to implement the behavior of methods componentName, componentName:, componentConnector and componentConnector:.

Also,  a component needs a definition. My subclasses have to use a trait which use ComponentType trait. See ComponentType for more informations.

Naming conventions for all my  subclasses :
<component type name>[something relative to my specific implementation]ComponentImpl.
If the component has only one implementation, it is not necessary to precise something about the specific implementation.

"
Class {
	#name : #MolAbstractComponentImpl,
	#superclass : #Object,
	#traits : 'MolComponentImpl',
	#classTraits : 'MolComponentImpl classTrait',
	#instVars : [
		'componentName',
		'componentConnector'
	],
	#category : #'Molecule-Core-Impl'
}

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> componentConnector [
^componentConnector 
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> componentConnector: aConnector [
	componentConnector := aConnector.
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> componentName [
	^componentName
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> componentName: aName [

	componentName := aName
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> eventNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> eventSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> eventsNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> eventsSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'component connecting' }
MolAbstractComponentImpl >> forEvents: anEventTrait removeProducer: aProducer [

	| producers |
	producers := self eventsSubscribers at: anEventTrait.
	producers isArray 
		ifTrue: [ (self eventsSubscribers at: anEventTrait) remove: aProducer ]
		ifFalse: [ (self eventsSubscribers removeKey: anEventTrait ) ]
]

{ #category : #'component connecting' }
MolAbstractComponentImpl >> forEvents: anEventTrait useAllProducers: aProducerList [

	self eventsSubscribers at: anEventTrait put: aProducerList
]

{ #category : #'component connecting' }
MolAbstractComponentImpl >> forEvents: anEventTrait useProducer: aProducer [

	(anEventTrait traits includes: MolComponentEvents)
		ifTrue: [self eventsSubscribers at: anEventTrait put: aProducer]
		ifFalse: [ MolUtils log: self printString, '>forEvent:useProducer: try to link a non event trait for an event ' ]
]

{ #category : #'component connecting' }
MolAbstractComponentImpl >> forServices: aServiceTrait useProvider: aServiceProvider [

	(aServiceTrait traits includes: MolComponentServices)
		ifTrue: [self servicesProviders at: aServiceTrait put: aServiceProvider]
		ifFalse: [ MolUtils log: self printString, '>forService:useProvider: try to link a non services trait for services ' ]
]

{ #category : #'private component accessing' }
MolAbstractComponentImpl >> servicesProviders [

	^ self componentConnector servicesProviders
]
