"
I am a component impl overloading my contract for impl purpose
"
Class {
	#name : #MolCompleteComponentOverloadImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolCompleteComponent + MolUsedServices + MolUsedEvents + MolUsedParameters + MolUsedParameters2 + MolUsedServices2 + MolUsedEvents2',
	#classTraits : 'MolCompleteComponent classTrait + MolUsedServices classTrait + MolUsedEvents classTrait + MolUsedParameters classTrait + MolUsedParameters2 classTrait + MolUsedServices2 classTrait + MolUsedEvents2 classTrait',
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #'accessing - events' }
MolCompleteComponentOverloadImpl class >> consumedComponentEvents [

	<componentContract>
	^ { MolUsedEvents. MolUsedEvents2 }
]

{ #category : #'accessing - events' }
MolCompleteComponentOverloadImpl class >> producedComponentEvents [

	<componentContract> 
	^ {
		  MolUsedEvents.
		  MolUsedEvents2 }
]

{ #category : #'accessing - parameters' }
MolCompleteComponentOverloadImpl class >> providedComponentParameters [

	<componentContract>
	^ { MolUsedParameters. MolUsedParameters2. }
]

{ #category : #'accessing - services' }
MolCompleteComponentOverloadImpl class >> providedComponentServices [

	<componentContract>
	^ { MolUsedServices. MolUsedServices2 }
]

{ #category : #'accessing - parameters' }
MolCompleteComponentOverloadImpl class >> usedComponentParameters [

	<componentContract>
	^ { MolUsedParameters. MolUsedParameters2 }
]

{ #category : #'accessing - services' }
MolCompleteComponentOverloadImpl class >> usedComponentServices [

	<componentContract>
	^ { MolUsedServices. MolUsedServices2 }
]

{ #category : #events }
MolCompleteComponentOverloadImpl >> event [
	^ #event
]

{ #category : #'component accessing' }
MolCompleteComponentOverloadImpl >> getMolUsedEvents2Notifier [
	^self eventsNotifiers at: MolUsedEvents2 ifAbsent: [^MolNotFoundEventsNotifier new interface: MolUsedEvents2 name: nil].
]

{ #category : #'component accessing' }
MolCompleteComponentOverloadImpl >> getMolUsedEvents2Subscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolUsedEvents2.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolUsedEvents2 named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolCompleteComponentOverloadImpl >> getMolUsedEventsNotifier [
	^self eventsNotifiers at: MolUsedEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolUsedEvents name: nil].
]

{ #category : #'component accessing' }
MolCompleteComponentOverloadImpl >> getMolUsedEventsSubscriber [
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
MolCompleteComponentOverloadImpl >> getMolUsedParameters2Provider [
	| parametersSymbol parametersProvider itf |

	itf := MolUsedParameters2.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [nil].
	(parametersSymbol isNil or:[parametersSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundParametersProvider new interface: itf name: nil ].

	parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: MolUsedParameters2 named: parametersSymbol.
	^parametersProvider
]

{ #category : #'component accessing' }
MolCompleteComponentOverloadImpl >> getMolUsedParametersProvider [
	| parametersSymbol parametersProvider itf |

	itf := MolUsedParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [nil].
	(parametersSymbol isNil or:[parametersSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundParametersProvider new interface: itf name: nil ].

	parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: MolUsedParameters named: parametersSymbol.
	^parametersProvider
]

{ #category : #'component accessing' }
MolCompleteComponentOverloadImpl >> getMolUsedServices2Provider [
	| servicesSymbol servicesProvider itf |

	itf := MolUsedServices2.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].
	(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices2 named: servicesSymbol.
	^servicesProvider
]

{ #category : #'component accessing' }
MolCompleteComponentOverloadImpl >> getMolUsedServicesProvider [
	| servicesSymbol servicesProvider itf |

	itf := MolUsedServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].
	(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices named: servicesSymbol.
	^servicesProvider
]

{ #category : #parameters }
MolCompleteComponentOverloadImpl >> parameter [
	^ #parameter
]

{ #category : #service }
MolCompleteComponentOverloadImpl >> service [
	^ #service
]
