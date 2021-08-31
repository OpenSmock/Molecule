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
MolComponentImplTest >> testAugmentedClassToAComponentProperties [
	| component |

	component := MolAugmentedClassToAComponentWithoutType new.

	self assert: component class isComponentClass.
	self assert: component class haveComponentType equals: false.

	"Component name"
	self assert: component componentName equals: nil.
	component componentName: #default.
	self assert: component componentName equals: #default.
	
	"Component connector, just test if accessors exists because componentConnector is managed on component instanciation"
	self assert: component componentConnector equals: nil.
	component componentConnector: nil.
	self assert: component componentConnector equals: nil.
]

{ #category : #tests }
MolComponentImplTest >> testAugmentedClassToAComponentRemoveAndReuseAsNormalWay [
	"Use an existing class to a component, remove the component and reuse the instance as a normal way"

	| myInstance |
	"Start the component"
	myInstance := MolUtils startComponent: MolAugmentedClassToAComponent.
	self assert: myInstance service equals: #service2.
	self assert: myInstance parameter equals: #parameter2.
	
	"Stop the component but after use instance as a normal way"	
	MolUtils stopComponent: MolAugmentedClassToAComponent.
	"Use classic methods wich uses component methods and check if no errors are rising in case of using these methods in the classic implementation"
	self assert: myInstance existingInterfaceA.
	self assert: myInstance existingInterfaceB.
	self assert: myInstance existingInterfaceC.
	myInstance getMolUsedEventsSubscriber subscribe: myInstance.
	myInstance getMolUsedEventsSubscriber unsubscribe: myInstance.
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

{ #category : #'test - contract' }
MolComponentImplTest >> testComponentType [ 

	self assert: MolComponentImpl componentType equals: nil.
	self assert: MolCompleteComponentImpl componentType equals: MolCompleteComponent.
	self assert: MolTestComponentImplA componentType equals: nil.
	
	"inheritance"
	self assert: MolCompleteComponentChildImpl componentType equals: MolCompleteComponentChild.
	
	
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

{ #category : #'test - contract' }
MolComponentImplTest >> testHaveComponentType [ 

	self assert: MolComponentImpl haveComponentType equals: false.
]

{ #category : #'test - contract' }
MolComponentImplTest >> testIsComponent [

	self assert: MolComponentImpl isComponentClass.
]

{ #category : #'test - contract' }
MolComponentImplTest >> testIsOverrideComponentType [

	self assert: MolCompleteComponentImpl isOverrideComponentType equals: false.
	self assert: MolCompleteComponentChildImpl isOverrideComponentType equals: true.
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

{ #category : #'test - contract' }
MolComponentImplTest >> testOverridedComponentTypes [

	self assert: MolCompleteComponentImpl overridedComponentTypes isEmpty.
	self assert: MolCompleteComponentChildImpl overridedComponentTypes size equals: 1.
	self assert: MolCompleteComponentChildImpl overridedComponentTypes first equals: MolCompleteComponent.
]

{ #category : #'tests - component creation' }
MolComponentImplTest >> testStart [
	MolCompleteComponentImpl deploy.
	MolCompleteComponentImpl instanciate.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl) notNil.
	MolCompleteComponentImpl activate.
	MolCompleteComponentImpl passivate.
	MolCompleteComponentImpl remove.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl) isNil.
	MolCompleteComponentImpl undeploy.
]

{ #category : #'tests - component creation' }
MolComponentImplTest >> testStart2 [
	| component |
	component := MolCompleteComponentImpl start.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl) notNil.
	self assert: component isComponent.
	self assert: component componentName equals: #default.
	
	component := MolCompleteComponentImpl start: #compA.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl named: #compA) notNil.
	self assert: component isComponent.
	self assert: component componentName equals: #compA.
]

{ #category : #'tests - component creation' }
MolComponentImplTest >> testStartWithName [
	MolCompleteComponentImpl deploy.
	MolCompleteComponentImpl instanciate: #myComponent.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl named: #myComponent) notNil.
	MolCompleteComponentImpl activate: #myComponent.
	MolCompleteComponentImpl passivate: #myComponent.
	MolCompleteComponentImpl remove: #myComponent.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl named: #myComponent) isNil.
	MolCompleteComponentImpl undeploy.
]

{ #category : #'tests - component creation' }
MolComponentImplTest >> testStop [
	MolCompleteComponentImpl start.
	MolCompleteComponentImpl stop.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl) equals: nil.
	
	MolCompleteComponentImpl start: #compA.
	MolCompleteComponentImpl stop: #compA.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl named: #compA) equals: nil.
	
]
