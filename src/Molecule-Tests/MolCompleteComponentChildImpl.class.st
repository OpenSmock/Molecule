Class {
	#name : #MolCompleteComponentChildImpl,
	#superclass : #MolCompleteComponentImpl,
	#traits : 'MolCompleteComponentChild + MolUsedChildEvents + MolUsedChildServices + MolUsedChildParameters',
	#classTraits : 'MolCompleteComponentChild classTrait + MolUsedChildEvents classTrait + MolUsedChildServices classTrait + MolUsedChildParameters classTrait',
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #'component accessing' }
MolCompleteComponentChildImpl >> getMolUsedChildEventsNotifier [
	^self eventsNotifiers at: MolUsedChildEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolUsedChildEvents name: nil].
]

{ #category : #'component accessing' }
MolCompleteComponentChildImpl >> getMolUsedChildEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolUsedChildEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolUsedChildEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolCompleteComponentChildImpl >> getMolUsedChildParametersProvider [
	| parametersSymbol parametersProvider itf |

	itf := MolUsedChildParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [nil].
	(parametersSymbol isNil or:[parametersSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundParametersProvider new interface: itf name: nil ].

	parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: MolUsedChildParameters named: parametersSymbol.
	^parametersProvider
]

{ #category : #'component accessing' }
MolCompleteComponentChildImpl >> getMolUsedChildServicesProvider [
	| servicesSymbol servicesProvider itf |

	itf := MolUsedChildServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].
	(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedChildServices named: servicesSymbol.
	^servicesProvider
]
