Class {
	#name : #MolComponentImplTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #running }
MolComponentImplTest >> setUp [
	MolComponentManager cleanUp.
	super setUp 
]

{ #category : #running }
MolComponentImplTest >> tearDown [
	super tearDown.
	MolComponentManager cleanUp
]

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
MolComponentImplTest >> testAugmentedClassToAComponentUsesAsAClassicWay [
	"Use existing API outside a Component system but with component capacities use inside (get services, parameters and notify events)"

	| myInstance |
	myInstance := MolAugmentedClassToAComponent new.
	self assert: myInstance existingInterfaceA.
	self assert: myInstance existingInterfaceB.
	self assert: myInstance existingInterfaceC.
]

{ #category : #tests }
MolComponentImplTest >> testDefineComponent [

	self assert: MolComponentImpl defineComponent equals: MolComponentImpl.
]

{ #category : #tests }
MolComponentImplTest >> testFoundNotifier [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedEventsNotifier isNotFoundEventsNotifier not.
]

{ #category : #tests }
MolComponentImplTest >> testFoundParameters [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedParametersProvider isNotFoundParameters not.
]

{ #category : #tests }
MolComponentImplTest >> testFoundServices [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedServicesProvider isNotFoundServices not.
]

{ #category : #tests }
MolComponentImplTest >> testFoundSubscriber [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedEventsSubscriber isNotFoundEventsSubscriber not.
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
MolComponentImplTest >> testNotFoundNotifier [

	| component result |
	component := MolCompleteComponentImpl new.
	
	self assert: component getMolUsedEventsNotifier isNotFoundEventsNotifier.
	
	result := component getMolUsedEventsNotifier event.
	self assert: result isNil.
]

{ #category : #tests }
MolComponentImplTest >> testNotFoundParameters [

	| component result |
	component := MolCompleteComponentImpl new.
	
	self assert: component getMolUsedParametersProvider isNotFoundParameters.
	
	result := component getMolUsedParametersProvider parameter.
	self assert: result isNil.
]

{ #category : #tests }
MolComponentImplTest >> testNotFoundServices [

	| component result |
	component := MolCompleteComponentImpl new.
	
	self assert: component getMolUsedServicesProvider isNotFoundServices.
	
	result := component getMolUsedServicesProvider service.
	self assert: result isNil.
]

{ #category : #tests }
MolComponentImplTest >> testNotFoundSubscriber [

	| component |
	component := MolCompleteComponentImpl new.
	
	self assert: component getMolUsedEventsSubscriber isNotFoundEventsSubscriber.
	
	component getMolUsedEventsSubscriber subscribe: self.
	component getMolUsedEventsSubscriber unsubscribe: self.
]
