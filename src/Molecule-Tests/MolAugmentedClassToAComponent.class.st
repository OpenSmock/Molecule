Class {
	#name : #MolAugmentedClassToAComponent,
	#superclass : #Object,
	#traits : 'MolComponentImpl + MolCompleteComponent + MolUsedEvents + MolUsedServices + MolUsedParameters',
	#classTraits : 'MolComponentImpl classTrait + MolCompleteComponent classTrait + MolUsedEvents classTrait + MolUsedServices classTrait + MolUsedParameters classTrait',
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #'existing class API' }
MolAugmentedClassToAComponent >> existingInterfaceA [
	"Return true"

	^ true 
]

{ #category : #'existing class API' }
MolAugmentedClassToAComponent >> existingInterfaceB [
	"Return true and send an event"

	self getMolUsedEventsNotifier event.
	^ true
]

{ #category : #'existing class API' }
MolAugmentedClassToAComponent >> existingInterfaceC [
	"Return true and use a service and a parameter"

	| result result2 |
	result := self getMolUsedServicesProvider service.
	result2 := self getMolUsedParametersProvider parameter.
	^ true
]

{ #category : #'component accessing' }
MolAugmentedClassToAComponent >> getMolUsedEventsNotifier [
	^self eventsNotifiers at: MolUsedEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolUsedEvents name: nil].
]

{ #category : #'component accessing' }
MolAugmentedClassToAComponent >> getMolUsedEventsSubscriber [
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
MolAugmentedClassToAComponent >> getMolUsedParametersProvider [
	| parametersSymbol parametersProvider itf |

	itf := MolUsedParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [nil].
	(parametersSymbol isNil or:[parametersSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundParametersProvider new interface: itf name: nil ].

	parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: MolUsedParameters named: parametersSymbol.
	^parametersProvider
]

{ #category : #'component accessing' }
MolAugmentedClassToAComponent >> getMolUsedServicesProvider [
	| servicesSymbol servicesProvider itf |

	itf := MolUsedServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].
	(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices named: servicesSymbol.
	^servicesProvider
]

{ #category : #parameters }
MolAugmentedClassToAComponent >> parameter [
	^ #parameter2
]

{ #category : #service }
MolAugmentedClassToAComponent >> service [
	^ #service2
]
