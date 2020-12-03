"
A MolLocatorServicesTest is a test class for testing the behavior of MolLocatorServices
"
Class {
	#name : #MolLocatorServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolLocatorServicesTest >> setUp [ 

	MolComponentManager cleanUp.
]

{ #category : #tests }
MolLocatorServicesTest >> tearDown [  

	MolComponentManager cleanUp.
]

{ #category : #tests }
MolLocatorServicesTest >> testManyComponentsSearchServiceProviderFor [
	| servicesProvider comp1 comp2 comp3 |

	comp1 := MolUtils startComponent: MolCompleteComponentImpl.
	comp2 := MolUtils startComponent: MolCompleteComponentImpl named: #comp2.
	comp3 := MolUtils startComponent: MolCompleteComponentImpl named: #comp3.

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices.
	self assert: servicesProvider equals: comp1.
	
	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices named: #comp2.
	self assert: servicesProvider equals: comp2.
	
	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices named: #comp3.
	self assert: servicesProvider equals: comp3.
]

{ #category : #tests }
MolLocatorServicesTest >> testNotFoundParametersProvider [
	| parametersProvider |
	
	parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: MolUnusedParameters.
	
	self assert: parametersProvider isNotFoundParameters.
	self assert: parametersProvider connect equals: nil.

]

{ #category : #tests }
MolLocatorServicesTest >> testNotFoundServiceProvider [
	| serviceProvider |

	serviceProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUnusedServices.
	
	self assert: serviceProvider isNotFoundServices.
	self assert: serviceProvider connect equals: nil.
	
]

{ #category : #tests }
MolLocatorServicesTest >> testNotReadySearchEventSubscriberFor [
	| eventSubscriber |

	"search a no yet ready subscriber, because the component is not started"
	eventSubscriber := MolComponentManager default locatorServices searchEventsSubscriberFor: MolUsedEvents.

	self assert: (eventSubscriber isKindOf: MolEventSubscriber).
	self assert: (eventSubscriber getOriginators isEmpty).
	self assert: (eventSubscriber observersConnection isEmpty).
]

{ #category : #tests }
MolLocatorServicesTest >> testSearchEventSubscriberFor [
	| eventSubscriber component |

	component := MolUtils startComponent: MolCompleteComponentImpl.	
	eventSubscriber := MolComponentManager default locatorServices searchEventsSubscriberFor: MolUsedEvents.

	self assert: (eventSubscriber isKindOf: MolEventSubscriber).
	self assert: eventSubscriber getOriginators size equals: 1.
	self assert: eventSubscriber getOriginators first equals: component.
	self assert: (eventSubscriber observersConnection isEmpty).
]

{ #category : #tests }
MolLocatorServicesTest >> testSearchParametersProviderFor [
	| manager parametersProvider |
	
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	manager homeServices instanciateComponent: MolCompleteComponentImpl.
	parametersProvider := manager locatorServices searchParametersProviderFor: MolUsedParameters.
	
	self assert: parametersProvider isNotFoundParameters not.
	self assert: (parametersProvider isKindOf: MolCompleteComponentImpl).
]

{ #category : #tests }
MolLocatorServicesTest >> testSearchServiceProviderFor [
	| manager servicesProvider |

	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	manager homeServices instanciateComponent: MolCompleteComponentImpl.
	servicesProvider := manager locatorServices searchServicesProviderFor: MolUsedServices.
	
	self assert: servicesProvider isNotFoundServices not.
	self assert: (servicesProvider isKindOf: MolCompleteComponentImpl).
]
