Class {
	#name : #MolCompleteComponentChildImpl,
	#superclass : #MolCompleteComponentImpl,
	#traits : 'MolCompleteComponentChild + MolUsedChildEvents + MolUsedChildServices + MolUsedChildParameters',
	#classTraits : 'MolCompleteComponentChild classTrait + MolUsedChildEvents classTrait + MolUsedChildServices classTrait + MolUsedChildParameters classTrait',
	#category : #'Molecule-Tests-Resources - Implementations'
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
	parametersSymbol := self parametersProviders at: itf ifAbsent: [^MolNotFoundParametersProvider new interface: itf name: nil].
	parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: MolUsedChildParameters named: parametersSymbol]. 
	^parametersProvider
]

{ #category : #'component accessing' }
MolCompleteComponentChildImpl >> getMolUsedChildServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolUsedChildServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolUsedChildServices named: servicesSymbol]. 
	^servicesProvider
]
