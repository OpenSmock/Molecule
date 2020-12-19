"
I am used to test some methods of LocatorServices
"
Class {
	#name : #MolCompleteComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolCompleteComponent + MolUsedEvents + MolUsedServices + MolUsedParameters',
	#classTraits : 'MolCompleteComponent classTrait + MolUsedEvents classTrait + MolUsedServices classTrait + MolUsedParameters classTrait',
	#category : #'Molecule-Tests-Services Events Parameters Resources'
}

{ #category : #'component accessing' }
MolCompleteComponentImpl >> getMolUsedEventsNotifier [
	^self eventsNotifiers at: MolUsedEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: itf name: nil].
]

{ #category : #'component accessing' }
MolCompleteComponentImpl >> getMolUsedEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolUsedEvents.
	eventsSymbol := self eventsSubscribers at: itf  ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolUsedEvents named:  eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolCompleteComponentImpl >> getMolUsedParametersProvider [
	| parametersSymbol parametersProvider itf |
	itf := MolUsedParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [^MolNotFoundParametersProvider new interface: itf name: nil].
	parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: MolUsedParameters named:  parametersSymbol]. 
	^parametersProvider
]

{ #category : #'component accessing' }
MolCompleteComponentImpl >> getMolUsedServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolUsedServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolUsedServices named:  servicesSymbol]. 
	^servicesProvider
]
