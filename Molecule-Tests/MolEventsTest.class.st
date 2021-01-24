"
I provide basic tests for events.
Also, I can be used as example to use events. My classes are in package Molecule-Examples.
"
Class {
	#name : #MolEventsTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #'setUp - tearDown' }
MolEventsTest >> setUp [

	super setUp.
	MolComponentManager cleanUp.
]

{ #category : #'setUp - tearDown' }
MolEventsTest >> tearDown [

	MolComponentManager cleanUp.
	super tearDown.
]

{ #category : #tests }
MolEventsTest >> testSeveralListeners [
	| manager warner listener1 listener2 |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #warner.
	listener1 := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #listener1.
	listener2 := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #listener2.
	
	"Subscriptions"
	listener1 forEvents: MolMyStateChangeEvents useProducer: #warner.
	listener2 forEvents: MolMyStateChangeEvents useProducer: #warner.
	
	"Activation"
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #warner.
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #listener1.
	
	"Tests"
	warner operationalEvent.
	self assert: listener1 currentState equals: #operational.
	self assert: listener2 currentState equals: nil.
	
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #listener2.
	warner maintenanceEvent.
	self assert: listener1 currentState equals: #maintenance.
	self assert: listener2 currentState equals: #maintenance.
	
	manager homeServices passivateComponent: MolMyListenerComponentImpl named: #listener1.
	warner failureEvent.
	self assert: listener1 currentState equals: #maintenance.
	self assert: listener2 currentState equals: #failure.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSeveralWarners [
	| manager warner1 warner2 listener subscriptions subscribers |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation"
	warner1 := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #warner1.
	warner2 := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #warner2.
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #listener.
	
	"Subscriptions"
	subscriptions := (Array with: #warner1 with: #warner2).
	listener forEvents: MolMyStateChangeEvents useAllProducers: subscriptions.

	subscribers := listener eventsSubscribers.	
	self assert: subscribers size equals: 1.
	self assert: (subscribers at: MolMyStateChangeEvents) size equals: 2.
	self assert: ((subscribers at: MolMyStateChangeEvents) at: 1) equals: #warner1.
	self assert: ((subscribers at: MolMyStateChangeEvents) at: 2) equals: #warner2.
	
	"Activation"
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #warner1.
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #listener.
	
	"Tests"
	warner1 operationalEvent.
	self assert: listener currentState equals: #operational.
	warner2 failureEvent.
	self assert: listener currentState equals: #failure.
	
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #warner2.
	warner1 maintenanceEvent.
	self assert: listener currentState equals: #maintenance.
	warner2 failureEvent.
	self assert: listener currentState equals: #failure.
	
	manager homeServices passivateComponent: MolMyWarnerComponentImpl named: #warner1.
	warner1 operationalEvent.
	self assert: listener currentState equals: #operational.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSimpleListenerNotActivated [
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl.
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl.
	
	"Activation / Passivation"
	manager homeServices activateComponent: MolMyWarnerComponentImpl.
	
	warner operationalEvent.
	self assert: listener currentState equals: nil.
		
	manager homeServices activateComponent: MolMyListenerComponentImpl.
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	
	manager homeServices passivateComponent: MolMyListenerComponentImpl.
	warner maintenanceEvent.
	self assert: listener currentState equals: #operational.
	
	manager homeServices activateComponent: MolMyListenerComponentImpl.
	warner maintenanceEvent.
	self assert: listener currentState equals: #maintenance.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSimpleListenerNotActivatedNamed [
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #myWarner.
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #myListener.
	
	"Subscription"
	listener forEvents: MolMyStateChangeEvents useProducer: #myWarner.
	
	"Activation"
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #myWarner.
	
	warner operationalEvent.
	self assert: listener currentState equals: nil.
		
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #myListener.
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	
	manager homeServices passivateComponent: MolMyListenerComponentImpl named: #myListener.
	warner maintenanceEvent.
	self assert: listener currentState equals: #operational.
	
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #myListener.
	warner maintenanceEvent.
	self assert: listener currentState equals: #maintenance.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
]

{ #category : #tests }
MolEventsTest >> testSimpleWarnerNotActivated [
	"A component not activated send events."
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl.
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl.
	
	"Activation"
	manager homeServices activateComponent: MolMyListenerComponentImpl.
	
	"Tests"
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	
	manager homeServices activateComponent: MolMyWarnerComponentImpl.
	warner failureEvent.
	self assert: listener currentState equals: #failure.
	
	manager homeServices passivateComponent: MolMyWarnerComponentImpl.
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	
	manager homeServices activateComponent: MolMyWarnerComponentImpl.
	warner maintenanceEvent.
	self assert: listener currentState equals: #maintenance.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSimpleWarnerNotActivatedNamed [
	"A component not activated send events."
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #myWarner.
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #myListener.
	
	"Subscription"
	listener forEvents: MolMyStateChangeEvents useProducer: #myWarner.
	
	"Activation"
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #myListener.
	
	"Tests"
	warner maintenanceEvent.
	self assert: listener currentState equals: #maintenance.
	
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #myWarner.
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	
	manager homeServices passivateComponent: MolMyWarnerComponentImpl named: #myWarner.
	warner maintenanceEvent.
	self assert: listener currentState equals: #maintenance.
	
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #myWarner.
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSimpleWarningSystem [
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation : by default, components name is #default"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl.
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl.
	
	"Subscription : by default, a component is subscribed to events from component #default."
	"It will be effective after activation"
	
	"Activation : by default, components are activated with name default"
	manager homeServices activateComponent: MolMyWarnerComponentImpl.
	manager homeServices activateComponent: MolMyListenerComponentImpl.
	
	"Tests"
	self assert: listener currentState equals: nil.
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	warner failureEvent.
	self assert: listener currentState equals: #failure.
	self assert: listener failureLevel notNil.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSimpleWarningSystemNamed [
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Instanciation"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #myWarner.
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #myListener.
	
	"Subscription : it should be done in SCMMyListenerComponentImpl > componentInitialize"
	listener forEvents: MolMyStateChangeEvents useProducer: #myWarner.
	
	"Activation"
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #myWarner.
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #myListener.
	
	"Tests"
	self assert: listener currentState equals: nil.
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	warner failureEvent.
	self assert: listener currentState equals: #failure.
	self assert: listener failureLevel notNil.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSimpleWarningSystemNamedDelayed [
"Test subscription after activation"
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Initialization and activation of listener"
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #myListener.
	listener forEvents: MolMyStateChangeEvents useProducer: #myWarner. "Warner does not exist."
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #myListener.
	
	"Initialization and activation of warner"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #myWarner.
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #myWarner.
	
	"Tests"
	warner operationalEvent.
	self assert: listener currentState equals: #operational.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]

{ #category : #tests }
MolEventsTest >> testSubscriptionBeforeInstanciation [
	"A component not activated send events."
	| manager warner listener |
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyListenerComponentImpl.
	
	"Creation and subscription of listener"
	listener := manager homeServices instanciateComponent: MolMyListenerComponentImpl named: #myListener.
	listener forEvents: MolMyStateChangeEvents useProducer: #myWarner.
	manager homeServices activateComponent: MolMyListenerComponentImpl named: #myListener.
	
	"Creation of warner"
	warner := manager homeServices instanciateComponent: MolMyWarnerComponentImpl named: #myWarner.
	manager homeServices activateComponent: MolMyWarnerComponentImpl named: #myWarner.
	
	"Test"
	warner maintenanceEvent.
	self assert: listener currentState equals: #maintenance.
	
	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	
]
