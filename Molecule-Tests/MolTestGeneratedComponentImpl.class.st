Class {
	#name : #MolTestGeneratedComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolTestGeneratedComponentType + MolTestGeneratedComponentServices + MolTestGeneratedComponentEvents + MolTestGeneratedComponentParameters',
	#classTraits : 'MolTestGeneratedComponentType classTrait + MolTestGeneratedComponentServices classTrait + MolTestGeneratedComponentEvents classTrait + MolTestGeneratedComponentParameters classTrait',
	#category : #'Molecule-Tests-Resources - Generated'
}

{ #category : #'component accessing' }
MolTestGeneratedComponentImpl >> getMolTestGeneratedComponentEventsNotifier [
	^self eventsNotifiers at: MolTestGeneratedComponentEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolTestGeneratedComponentEvents name: nil].
]

{ #category : #'component accessing' }
MolTestGeneratedComponentImpl >> getMolTestGeneratedComponentEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolTestGeneratedComponentEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolTestGeneratedComponentEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolTestGeneratedComponentImpl >> getMolTestGeneratedComponentParametersProvider [
	| parametersSymbol parametersProvider itf |
	itf := MolTestGeneratedComponentParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [^MolNotFoundParametersProvider new interface: itf name: nil].
	parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: MolTestGeneratedComponentParameters named: parametersSymbol]. 
	^parametersProvider
]

{ #category : #'component accessing' }
MolTestGeneratedComponentImpl >> getMolTestGeneratedComponentServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolTestGeneratedComponentServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolTestGeneratedComponentServices named: servicesSymbol]. 
	^servicesProvider
]
