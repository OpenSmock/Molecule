Class {
	#name : #MolComponentImplTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolComponentImplTest >> testAugmentedClassToAComponentConnecting [

	| component |
	component := MolUtils startComponent: MolAugmentedClassToAComponent.

	self assert: component componentName equals: #default.
	self assert: (component componentConnector isKindOf: MolComponentConnector).

	self assert: component eventsNotifiers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty.
	self assert: component eventsSubscribers notEmpty.

	component forServices: MolServicesTest useProvider:  #default. 
	component forEvents: MolEventsTest useProducer:  #default. 
	component forParameters: MolParametersTest useProvider:  #default. 
	
	MolUtils stopComponent: MolAugmentedClassToAComponent.
]

{ #category : #tests }
MolComponentImplTest >> testAugmentedClassToAComponentProperties [

	| component connector |
	component := MolAugmentedClassToAComponentWithoutType new.

	self assert: component class isComponent.
	self assert: component class haveComponentType equals: false.

	"Component name"
	self assert: component componentName equals: nil.
	component componentName: #default.
	self assert: component componentName equals: #default.
	
	"Component connector"
	self assert: component componentConnector equals: nil.
	connector := MolComponentConnector new.
	component componentConnector: connector.
	self assert: component componentConnector equals: connector.
]

{ #category : #tests }
MolComponentImplTest >> testDefineComponent [

	self assert: MolComponentImpl defineComponent equals: MolComponentImpl.
]

{ #category : #tests }
MolComponentImplTest >> testHaveComponentType [ 

	self assert: MolComponentImpl haveComponentType equals: false.
]

{ #category : #tests }
MolComponentImplTest >> testIsComponent [

	self assert: MolComponentImpl isComponent.
]

{ #category : #tests }
MolComponentImplTest >> testProtocolForComponentAccess [

	self assert: MolComponentImpl protocolForComponentAccess equals: 'component accessing'.
]
