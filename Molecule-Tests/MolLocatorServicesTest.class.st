"
A MolLocatorServicesTest is a test class for testing the behavior of MolLocatorServices
"
Class {
	#name : #MolLocatorServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolLocatorServicesTest >> testNotFoundParametersProvider [
	| parametersProvider |
	MolComponentManager cleanUp.
	
	parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: MolUnusedParameters.
	self assert: parametersProvider isNotFoundParameters.
	self assert: parametersProvider connect equals: nil.
	
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolLocatorServicesTest >> testNotFoundServiceProvider [
	| serviceProvider |
	MolComponentManager cleanUp.
	
	serviceProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUnusedServices.
	self assert: serviceProvider isNotFoundServices.
	self assert: serviceProvider connect equals: nil.
	
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolLocatorServicesTest >> testSearchEventSubscriberFor [
	| eventSubscriber |
	MolComponentManager cleanUp.
	
	eventSubscriber := MolComponentManager default locatorServices searchEventsSubscriberFor: MolUsedEvents.
	
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolLocatorServicesTest >> testSearchParametersProviderFor [

	| manager parametersProvider |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	manager homeServices instanciateComponent: MolCompleteComponentImpl.
	parametersProvider := manager locatorServices searchParametersProviderFor: MolUsedParameters.
	self assert: parametersProvider isNotFoundParameters not.
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolLocatorServicesTest >> testSearchServiceProviderFor [

	| manager parametersProvider |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	manager homeServices instanciateComponent: MolCompleteComponentImpl.
	parametersProvider := manager locatorServices searchServicesProviderFor: MolUsedServices.
	self assert: parametersProvider isNotFoundServices not.
	MolComponentManager cleanUp.
]
