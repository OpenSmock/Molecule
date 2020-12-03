Class {
	#name : #MolAugmentedClassToAComponent,
	#superclass : #Object,
	#traits : 'MolComponentImpl + MolCompleteComponent + MolUsedEvents + MolUsedServices + MolUsedParameters',
	#classTraits : 'MolComponentImpl classTrait + MolCompleteComponent classTrait + MolUsedEvents classTrait + MolUsedServices classTrait + MolUsedParameters classTrait',
	#category : #'Molecule-Tests-Resources'
}

{ #category : #'component accessing' }
MolAugmentedClassToAComponent >> getMolUsedEventsNotifier [
	^self eventsNotifiers at: MolUsedEvents ifAbsent: [nil]
]

{ #category : #'component accessing' }
MolAugmentedClassToAComponent >> getMolUsedEventsSubscriber [
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
MolAugmentedClassToAComponent >> getMolUsedParametersProvider [
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
MolAugmentedClassToAComponent >> getMolUsedServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolUsedServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [self error:'Services not found'].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolUsedServices named:  servicesSymbol]. 
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
