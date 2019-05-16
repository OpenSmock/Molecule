"
I am an example of user of table component. I have a method which give me an access to the table component.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyUserComponentImpl,
	#superclass : #Object,
	#traits : 'MolMyUserComponent + MolComponentImpl',
	#classTraits : 'MolMyUserComponent classTrait + MolComponentImpl classTrait',
	#instVars : [
		'name',
		'connector',
		'myTableServices'
	],
	#category : #'Molecule-Tests-Services Resources'
}

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> componentConnector [

	^ connector
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> componentConnector: aConnector [

	connector := aConnector
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> componentName [

	^ name
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> componentName: aName [

	name := aName
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> eventNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> eventSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> eventsNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> eventsSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'component connecting' }
MolMyUserComponentImpl >> forEvents: anEventTrait removeProducer: aProducer [

	| producers |
	producers := self eventsSubscribers at: anEventTrait.
	producers isArray 
		ifTrue: [ (self eventsSubscribers at: anEventTrait) remove: aProducer ]
		ifFalse: [ (self eventsSubscribers removeKey: anEventTrait ) ]
]

{ #category : #'component connecting' }
MolMyUserComponentImpl >> forEvents: anEventTrait useAllProducers: aProducerList [

	self eventsSubscribers at: anEventTrait put: aProducerList
]

{ #category : #'component connecting' }
MolMyUserComponentImpl >> forEvents: anEventTrait useProducer: aProducer [

	(anEventTrait traits includes: MolComponentEvents)
		ifTrue: [self eventsSubscribers at: anEventTrait put: aProducer]
		ifFalse: [ MolUtils log: self printString, '>forEvent:useProducer: try to link a non event trait for an event ' ]
]

{ #category : #'component connecting' }
MolMyUserComponentImpl >> forServices: aServiceTrait useProvider: aServiceProvider [

	(aServiceTrait traits includes: MolComponentServices)
		ifTrue: [self servicesProviders at: aServiceTrait put: aServiceProvider]
		ifFalse: [ MolUtils log: self printString, '>forService:useProvider: try to link a non services trait for services ' ]
]

{ #category : #'component accessing' }
MolMyUserComponentImpl >> getMolMyTableServicesProvider [
	| serviceSymbol serviceProvider itf |
	itf := MolMyTableServices.
	serviceSymbol := self servicesProviders at: itf ifAbsent: [self error:'service not found'].
	serviceSymbol isSymbol
	 	ifTrue: 
			[serviceProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolMyTableServices named:  serviceSymbol]. 
	^serviceProvider
]

{ #category : #'private component accessing' }
MolMyUserComponentImpl >> servicesProviders [

	^ self componentConnector servicesProviders
]
