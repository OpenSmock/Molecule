Class {
	#name : #MolCompleteComponent2Impl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolCompleteComponent2 + MolUsedEvents + MolUsedParameters + MolUsedServices',
	#classTraits : 'MolCompleteComponent2 classTrait + MolUsedEvents classTrait + MolUsedParameters classTrait + MolUsedServices classTrait',
	#category : 'Molecule-Tests-Resources - Components'
}

{ #category : #'component accessing' }
MolCompleteComponent2Impl >> getMolUsedEventsNotifier [
	^self eventsNotifiers at: MolUsedEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolUsedEvents name: nil].
]

{ #category : #'component accessing' }
MolCompleteComponent2Impl >> getMolUsedEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolUsedEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolUsedEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolCompleteComponent2Impl >> getMolUsedParametersProvider [
	| parametersSymbol parametersProvider itf |

	itf := MolUsedParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [nil].
	(parametersSymbol isNil or:[parametersSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundParametersProvider new interface: itf name: nil ].

	parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: MolUsedParameters named: parametersSymbol.
	^parametersProvider
]

{ #category : #'component accessing' }
MolCompleteComponent2Impl >> getMolUsedServicesProvider [
	| servicesSymbol servicesProvider itf |

	itf := MolUsedServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].
	(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices named: servicesSymbol.
	^servicesProvider
]
