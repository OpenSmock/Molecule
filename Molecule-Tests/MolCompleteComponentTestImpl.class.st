"
I am added and removed by test: MolComponentFactoryTest>>#testCreateImplementationForNamedIn
"
Class {
	#name : #MolCompleteComponentTestImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolCompleteComponent + MolUsedEvents + MolUsedServices + MolUsedParameters',
	#classTraits : 'MolCompleteComponent classTrait + MolUsedEvents classTrait + MolUsedServices classTrait + MolUsedParameters classTrait',
	#category : #'Molecule-Tests-Resources'
}

{ #category : #'component accessing' }
MolCompleteComponentTestImpl >> getMolUsedEventsNotifier [
	^self eventsNotifiers at: MolUsedEvents ifAbsent: [nil]
]

{ #category : #'component accessing' }
MolCompleteComponentTestImpl >> getMolUsedEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolUsedEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [self error:'Events not found'].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolUsedEvents named:  eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolCompleteComponentTestImpl >> getMolUsedParametersProvider [
	| parametersSymbol parametersProvider itf |
	itf := MolUsedParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [self error:'parameters not found'].
	parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: MolUsedParameters named:  parametersSymbol]. 
	^parametersProvider
]

{ #category : #'component accessing' }
MolCompleteComponentTestImpl >> getMolUsedServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolUsedServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [self error:'Services not found'].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolUsedServices named:  servicesSymbol]. 
	^servicesProvider
]
