"
I am an example of table which provide services to all its users. My services are defined with trait MyTableServices.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyTableComponentImpl,
	#superclass : #Object,
	#traits : 'MolMyTableComponent + MolComponentImpl + MolMyTableServices',
	#classTraits : 'MolMyTableComponent classTrait + MolComponentImpl classTrait + MolMyTableServices classTrait',
	#instVars : [
		'connector',
		'name',
		'tableContent',
		'columnNames'
	],
	#category : #'Molecule-Tests-Services Resources'
}

{ #category : #accessing }
MolMyTableComponentImpl >> addRow: aName attribute1: aNumber1 attribute2: aNumber2 [

	| collection |
	collection := OrderedCollection new
		add: aName;
		add: aNumber1;
		add: aNumber2.
	tableContent add: collection.
		
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> componentConnector [

	^ connector
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> componentConnector: aConnector [

	connector := aConnector
]

{ #category : #'component life cycle' }
MolMyTableComponentImpl >> componentInitialize [
	"here write the code corresponding to component initialisation phase"
	
	tableContent := OrderedCollection new.
	self addRow: 'Raw1' attribute1: 3 attribute2: 0.254.
	self addRow: 'Raw2' attribute1: 12 attribute2: 3.219.
	self addRow: 'Raw3' attribute1: 5 attribute2: 1.587.
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> componentName [

	^ name
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> componentName: aName [

	name := aName
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> eventNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> eventSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> eventsNotifiers [

	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> eventsSubscribers [

	^ self componentConnector eventsSubscribers
]

{ #category : #'component connecting' }
MolMyTableComponentImpl >> forEvents: anEventTrait removeProducer: aProducer [

	| producers |
	producers := self eventsSubscribers at: anEventTrait.
	producers isArray  
		ifTrue: [producers remove: aProducer ifAbsent:[nil]]
		ifFalse: [self eventsSubscribers removeKey: anEventTrait ifAbsent:[nil]]
]

{ #category : #'component connecting' }
MolMyTableComponentImpl >> forEvents: anEventTrait useAllProducers: aProducerList [

	self eventsSubscribers at: anEventTrait put: aProducerList
]

{ #category : #'component connecting' }
MolMyTableComponentImpl >> forEvents: anEventTrait useProducer: aProducer [

	(anEventTrait traits includes: MolComponentEvents)
		ifTrue: [self eventsSubscribers at: anEventTrait put: aProducer]
		ifFalse: [ MolUtils log: self printString, '>forEvent:useProducer: try to link a non event trait for an event ' ]
]

{ #category : #'component connecting' }
MolMyTableComponentImpl >> forServices: aServiceTrait useProvider: aServiceProvider [

	(aServiceTrait traits includes: MolComponentServices)
		ifTrue: [self servicesProviders at: aServiceTrait put: aServiceProvider]
		ifFalse: [ MolUtils log: self printString, '>forService:useProvider: try to link a non services trait for services ' ]
]

{ #category : #services }
MolMyTableComponentImpl >> getContent [

	^ tableContent
]

{ #category : #services }
MolMyTableComponentImpl >> getContentAtRow: aRowNumber [

	aRowNumber isInteger ifFalse: [ self error: 'Argument must be an integer.' ].
	^ tableContent at: aRowNumber
]

{ #category : #services }
MolMyTableComponentImpl >> nbOfRows [

	^ tableContent size
]

{ #category : #'private component accessing' }
MolMyTableComponentImpl >> servicesProviders [

	^ self componentConnector servicesProviders
]
