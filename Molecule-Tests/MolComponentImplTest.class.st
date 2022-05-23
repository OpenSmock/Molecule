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

{ #category : #test }
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

{ #category : #test }
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

{ #category : #test }
MolComponentImplTest >> testAugmentedClassToAComponentUsesAsAClassicWay [
	"Use existing API outside a Component system but with component capacities use inside (get services, parameters and notify events)"

	| myInstance |
	myInstance := MolAugmentedClassToAComponent new.
	self assert: myInstance existingInterfaceA.
	self assert: myInstance existingInterfaceB.
	self assert: myInstance existingInterfaceC.
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testChangeEventsProducersDuringSubscribe [

	| component |
	component := MolCompleteComponentImpl start: #myComponent.
	component getMolUsedEventsSubscriber subscribe: component.
	
	"Change events producers"
	component forEvents: MolUsedEvents addProducer: #componentA.
	
	
	
	
]

{ #category : #'test - contract' }
MolComponentImplTest >> testComponentType [ 

	self assert: MolBasicComponentImpl componentType equals: MolBasicComponent.
	self assert: MolBasicSubComponentImpl componentType equals: MolBasicComponent.
	
	
]

{ #category : #'test - contract' }
MolComponentImplTest >> testComponentType2 [

	self assert: MolComponentImpl componentType equals: nil.
	self assert: MolCompleteComponentImpl componentType equals: MolCompleteComponent.
	self assert: MolTestComponentImplA componentType equals: nil.
	
	"inheritance"
	self assert: MolCompleteComponentChildImpl componentType equals: MolCompleteComponentChild.
	
	
]

{ #category : #test }
MolComponentImplTest >> testDefineComponent [

	self assert: MolComponentImpl defineComponent equals: MolComponentImpl.
]

{ #category : #test }
MolComponentImplTest >> testEventsNotifiers [

	| component |
	
	component := MolCompleteComponentImpl new.
	
	self assert: component eventsNotifiers isEmpty.
	
	component := MolUtils deployAndInitializeComponent: MolCompleteComponentImpl named: #myComponentA.
	
	"Test initial events producer contents : default component name"
	self assert: component eventsNotifiers size equals: 1.
	self assert: ((component eventsNotifiers at: MolUsedEvents) isKindOf: MolEventNotifier).
	
	MolUtils activateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component eventsNotifiers size equals: 1.
	self assert: ((component eventsNotifiers at: MolUsedEvents) isKindOf: MolEventNotifier).
	
	MolUtils passivateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component eventsNotifiers size equals: 1.
	self assert: ((component eventsNotifiers at: MolUsedEvents) isKindOf: MolEventNotifier).
	
	MolUtils removeComponent: MolCompleteComponentImpl named: #myComponentA.

	self assert: component eventsNotifiers isEmpty.
]

{ #category : #test }
MolComponentImplTest >> testEventsSubscribers [

	| component |
	
	component := MolCompleteComponentImpl new.
	
	self assert: component eventsSubscribers isEmpty.
	
	component := MolUtils deployAndInitializeComponent: MolCompleteComponentImpl named: #myComponentA.
	
	"Test initial events producer contents : default component name"
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #default.
	
	MolUtils activateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #default.
	
	MolUtils passivateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #default.
	
	MolUtils removeComponent: MolCompleteComponentImpl named: #myComponentA.

	self assert: component eventsSubscribers isEmpty.
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testForEventsAddAllProducers [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.

	component forEvents: MolUsedEvents addAllProducers: #(#producerA #producerB #producerC).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#default #producerA #producerB #producerC).
	
	component forEvents: MolUsedEvents addAllProducers: #(#producerA #producerB #producerC #producerD #producerE #producerF).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#default #producerA #producerB #producerC #producerD #producerE #producerF).
	
	
]

{ #category : #test }
MolComponentImplTest >> testForEventsAddProducer [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.
	
	component forEvents: MolUsedEvents addProducer: #producerA.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#default #producerA).
	
	component forEvents: MolUsedEvents addProducer: #producerB.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#default #producerA #producerB).
	
	component forEvents: MolUsedEvents addProducer: #default.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#default #producerA #producerB).
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testForEventsRemoveAllProducers [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.

	component forEvents: MolUsedEvents addAllProducers: #(#producerA #producerB #producerC).

	component forEvents: MolUsedEvents removeAllProducers: #(#producerA #producerB #producerC #producerD #producerE #producerF).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #default.
	
	component forEvents: MolUsedEvents addAllProducers: #(#producerA #producerB #producerC).
	component forEvents: MolUsedEvents removeAllProducers: #(#producerA).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#default #producerB #producerC).
	
	component forEvents: MolUsedEvents removeAllProducers: #(#default #producerB #producerC).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: nil.
	
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testForEventsRemoveProducer [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.
	
	component forEvents: MolUsedEvents useAllProducers: #(#producerA #producerB #producerC).	
		
	component forEvents: MolUsedEvents removeProducer: #producerA.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#producerB #producerC).
	
	component forEvents: MolUsedEvents removeProducer: #producerB.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #producerC.
	
	component forEvents: MolUsedEvents removeProducer: #producerC.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: nil.
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testForEventsRemoveProducer2 [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.
	
	component forEvents: MolUsedEvents removeProducer: #default.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: nil.
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testForEventsUseAllProducers [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.

	component forEvents: MolUsedEvents useAllProducers: #(#producerA #producerB #producerC).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#producerA #producerB #producerC).
	
	component forEvents: MolUsedEvents useAllProducers: #(#producerD #producerE #producerF).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #(#producerD #producerE #producerF).
	
	component forEvents: MolUsedEvents useAllProducers: #().
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: nil.
	
	component forEvents: MolUsedEvents useAllProducers: nil.
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: nil.
	
	component forEvents: MolUsedEvents useAllProducers: #(#producerA).
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #producerA.
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testForEventsUseProducer [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.
	
	"Test set a specific producer"
	component forEvents: MolUsedEvents useProducer: #producerA. 
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #producerA.
	
	component forEvents: MolUsedEvents useProducer: #producerB. 
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #producerB.
	
	component forEvents: MolUsedEvents useProducer: nil. 
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: nil.
	
	component forEvents: MolUsedEvents useProducer: #default. 
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #default.
]

{ #category : #'test - connecting - events producers' }
MolComponentImplTest >> testForEventsUseProducer2 [

	| component |
	component := MolCompleteComponentImpl start: #myComponentA.
	component forEvents: MolUsedEvents useAllProducers: #(#producerA #producerB #producerC). 
	
	component forEvents: MolUsedEvents useProducer: #producerD. 
	self assert: component eventsSubscribers size equals: 1.
	self assert: (component eventsSubscribers at: MolUsedEvents) equals: #producerD.
	
	
]

{ #category : #test }
MolComponentImplTest >> testFoundNotifier [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedEventsNotifier isNotFoundEventsNotifier not.
]

{ #category : #test }
MolComponentImplTest >> testFoundParameters [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedParametersProvider isNotFoundParameters not.
]

{ #category : #test }
MolComponentImplTest >> testFoundServices [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedServicesProvider isNotFoundServices not.
]

{ #category : #test }
MolComponentImplTest >> testFoundSubscriber [

	| component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	
	self assert: component getMolUsedEventsSubscriber isNotFoundEventsSubscriber not.
]

{ #category : #'test - contract' }
MolComponentImplTest >> testHaveComponentType [ 

	self assert: MolComponentImpl haveComponentType equals: false.
	self assert: MolBasicComponentImpl haveComponentType equals: true.
	self assert: MolBasicSubComponentImpl haveComponentType equals: true.
]

{ #category : #'test - contract' }
MolComponentImplTest >> testHaveOwnComponentType [ 

	self assert: MolComponentImpl haveOwnComponentType equals: false.
	self assert: MolBasicComponentImpl haveOwnComponentType equals: true.
	self assert: MolBasicSubComponentImpl haveOwnComponentType equals: false.
]

{ #category : #'test - contract' }
MolComponentImplTest >> testIsComponent [

	self assert: MolComponentImpl isComponentClass.
]

{ #category : #'test - contract' }
MolComponentImplTest >> testIsOverrideComponentType [

	self assert: MolCompleteComponentImpl isOverrideComponentType equals: false.
	self assert: MolCompleteComponentChildImpl isOverrideComponentType equals: true.
	
	self assert: MolBasicComponentImpl isOverrideComponentType equals: false.
	self assert: MolBasicSubComponentImpl isOverrideComponentType equals: false.
]

{ #category : #test }
MolComponentImplTest >> testIsSubscribed [

	| component |
	component := MolCompleteComponentImpl start.
	self assert: (component isSubscribed: MolUsedEvents) equals: false. "can be true when subscribe"
	self assert: (component isSubscribed: MolUsedChildEvents) equals: false. "never be true"
	
	component getMolUsedEventsSubscriber subscribe: component.
	self assert: (component isSubscribed: MolUsedEvents) equals: true.
	self assert: (component isSubscribed: MolUsedChildEvents) equals: false. "never be true"
	
	component getMolUsedEventsSubscriber unsubscribe: component.
	self assert: (component isSubscribed: MolUsedEvents) equals: false.
	self assert: (component isSubscribed: MolUsedChildEvents) equals: false. "never be true"
	
	component getMolUsedEventsSubscriber subscribe: component.
	self assert: (component isSubscribed: MolUsedEvents) equals: true.
	self assert: (component isSubscribed: MolUsedChildEvents) equals: false. "never be true"

	MolCompleteComponentImpl stop.
	self assert: (component isSubscribed: MolUsedEvents) equals: false.
	self assert: (component isSubscribed: MolUsedChildEvents) equals: false. "never be true"
]

{ #category : #test }
MolComponentImplTest >> testNotFoundNotifier [

	| component result |
	component := MolCompleteComponentImpl new.
	
	self assert: component getMolUsedEventsNotifier isNotFoundEventsNotifier.
	
	result := component getMolUsedEventsNotifier event.
	self assert: result isNil.
]

{ #category : #test }
MolComponentImplTest >> testNotFoundParameters [

	| component result |
	component := MolCompleteComponentImpl new.
	
	self assert: component getMolUsedParametersProvider isNotFoundParameters.
	
	result := component getMolUsedParametersProvider parameter.
	self assert: result isNil.
]

{ #category : #test }
MolComponentImplTest >> testNotFoundServices [

	| component result |
	component := MolCompleteComponentImpl new.
	
	self assert: component getMolUsedServicesProvider isNotFoundServices.
	
	result := component getMolUsedServicesProvider service.
	self assert: result isNil.
]

{ #category : #test }
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

{ #category : #'test - contract' }
MolComponentImplTest >> testOwnComponentType [ 

	self assert: MolBasicComponentImpl ownComponentType equals: MolBasicComponent.
	self assert: MolBasicSubComponentImpl ownComponentType equals: nil.
	
	
]

{ #category : #test }
MolComponentImplTest >> testParametersProviders [

	| component |
	
	component := MolCompleteComponentImpl new.
	
	self assert: component parametersProviders isEmpty.
	
	component := MolUtils deployAndInitializeComponent: MolCompleteComponentImpl named: #myComponentA.
	
	"Test initial events producer contents : default component name"
	self assert: component parametersProviders size equals: 1.
	self assert: (component parametersProviders at: MolUsedParameters) equals: #default.
	
	MolUtils activateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component parametersProviders size equals: 1.
	self assert: (component parametersProviders at: MolUsedParameters) equals: #default.
	
	MolUtils passivateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component parametersProviders size equals: 1.
	self assert: (component parametersProviders at: MolUsedParameters) equals: #default.
	
	MolUtils removeComponent: MolCompleteComponentImpl named: #myComponentA.

	self assert: component parametersProviders isEmpty.
]

{ #category : #test }
MolComponentImplTest >> testServicesProviders [

	| component |
	
	component := MolCompleteComponentImpl new.
	
	self assert: component servicesProviders isEmpty.
	
	component := MolUtils deployAndInitializeComponent: MolCompleteComponentImpl named: #myComponentA.
	
	"Test initial events producer contents : default component name"
	self assert: component servicesProviders size equals: 1.
	self assert: (component servicesProviders at: MolUsedServices) equals: #default.
	
	MolUtils activateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component servicesProviders size equals: 1.
	self assert: (component servicesProviders at: MolUsedServices) equals: #default.
	
	MolUtils passivateComponent: MolCompleteComponentImpl named: #myComponentA.
	
	self assert: component servicesProviders size equals: 1.
	self assert: (component servicesProviders at: MolUsedServices) equals: #default.
	
	MolUtils removeComponent: MolCompleteComponentImpl named: #myComponentA.

	self assert: component servicesProviders isEmpty.
]

{ #category : #'test - component creation' }
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

{ #category : #'test - component creation' }
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

{ #category : #'test - component creation' }
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

{ #category : #'test - component creation' }
MolComponentImplTest >> testStop [
	MolCompleteComponentImpl start.
	MolCompleteComponentImpl stop.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl) equals: nil.
	
	MolCompleteComponentImpl start: #compA.
	MolCompleteComponentImpl stop: #compA.
	self assert: (MolUtils instanceOf: MolCompleteComponentImpl named: #compA) equals: nil.
	
]
