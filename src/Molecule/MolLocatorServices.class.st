"
I am responsible for find components in the system.

See examples of my use in Tests and Examples packages.
"
Class {
	#name : 'MolLocatorServices',
	#superclass : 'Object',
	#instVars : [
		'eventsSubscribers'
	],
	#category : 'Molecule-Core',
	#package : 'Molecule',
	#tag : 'Core'
}

{ #category : 'accessing' }
MolLocatorServices >> eventsSubscribers [
	eventsSubscribers isNil ifTrue: [eventsSubscribers := Dictionary new].
	^ eventsSubscribers
]

{ #category : 'accessing' }
MolLocatorServices >> eventsSubscribers: aDictionaryOrNil [
	eventsSubscribers := aDictionaryOrNil
]

{ #category : 'accessing' }
MolLocatorServices >> resolveWaitingSubscriptions: aComponent [
	| eventsAndProviders |

	self eventsSubscribers ifEmpty: [^self].
	
	eventsAndProviders := aComponent class allProducedEvents collect: [ :event | event -> aComponent componentName ].
	eventsAndProviders do: [ :asso | | subscribers |
		
		subscribers := self eventsSubscribers at: asso key ifAbsent:[ nil ].
	
		(subscribers notNil and:[subscribers isWaitingForSubscription]) ifTrue:[
			(subscribers includesOriginator: aComponent) ifFalse:[ 
				subscribers 	addOriginator: aComponent.
				subscribers linkOriginator: aComponent.
			].
			subscribers subscribeAllWaiting.
		].
	]
]

{ #category : 'searching' }
MolLocatorServices >> searchComponentTypeImplementorFor: aComponentType [

	^ self searchComponentTypeImplementorFor: aComponentType named: MolUtils defaultComponentName
]

{ #category : 'searching' }
MolLocatorServices >> searchComponentTypeImplementorFor: aComponentType named: aSymbol [
	| comps |
	
	comps := MolComponentManager default homeServices deployedComponents.
	comps keysDo: 
			[:comp | 
			((comp componentType = aComponentType) and: [(comps at: comp) includesKey: aSymbol]) 
				ifTrue: [^(comps at: comp) at: aSymbol]].
	^nil
]

{ #category : 'searching' }
MolLocatorServices >> searchEventsSubscriberFor: anEventsTrait [

	^ self searchEventsSubscriberFor: anEventsTrait named: MolUtils defaultComponentName
]

{ #category : 'searching' }
MolLocatorServices >> searchEventsSubscriberFor: anEventsTrait named: aSymbolOrArrayOfSymbols [
	| comps itf symbols subscribers events remainingNames |
	
	itf := anEventsTrait value.
	comps := MolComponentManager default homeServices deployedComponents.
	
	symbols := aSymbolOrArrayOfSymbols isSymbol
		ifTrue: [ Array with: aSymbolOrArrayOfSymbols ]
		ifFalse: [ aSymbolOrArrayOfSymbols copy ].
		
	remainingNames := symbols asOrderedCollection.
	subscribers := OrderedCollection new.
	comps keysDo: [ :comp | 
		(comp isProduceEvents: itf) ifTrue: [ (comps at: comp)
						collect: [ :inst | 
							(symbols includes: inst componentName)
								ifTrue: [ subscribers add: inst.
									remainingNames remove: inst componentName ifAbsent: [ nil ] ] ] 
		].
	].

	events := self eventsSubscribers at: itf ifAbsentPut: [ MolEventSubscriber events: itf originators: subscribers ].
	subscribers do: [ :e | events originatorsLinks at: e componentName put: e ].
	remainingNames do: [ :e | events originatorsLinks at: e put: nil].
	events addOriginators: subscribers.
	events linkOriginators: subscribers. 
	
	^ events
]

{ #category : 'searching' }
MolLocatorServices >> searchParametersProviderFor: aParametersTrait [

	^ self searchParametersProviderFor: aParametersTrait named: MolUtils defaultComponentName
]

{ #category : 'searching' }
MolLocatorServices >> searchParametersProviderFor: aParametersTrait named: aSymbol [

	| comps itf |
	itf := aParametersTrait value.
	comps := MolComponentManager default homeServices deployedComponents.
	comps keysDo: [ :comp |
		((comp isProvideParameters: itf) and: [
			 (comps at: comp) includesKey: aSymbol ]) ifTrue: [
			^ (comps at: comp) at: aSymbol ] ].
	
	^ MolNotFoundParametersProvider interface: aParametersTrait name: aSymbol
]

{ #category : 'searching' }
MolLocatorServices >> searchServicesProviderFor: aServicesTrait [

	^ self searchServicesProviderFor: aServicesTrait named: MolUtils defaultComponentName
]

{ #category : 'searching' }
MolLocatorServices >> searchServicesProviderFor: aServicesTrait named: aSymbol [

	| comps itf |
	itf := aServicesTrait value.
	comps := MolComponentManager default homeServices deployedComponents.
	comps keysDo: [ :comp |
		((comp isProvideServices: itf) and: [
			 (comps at: comp) includesKey: aSymbol ]) ifTrue: [
			^ (comps at: comp) at: aSymbol ] ].

	^ MolNotFoundServicesProvider interface: aServicesTrait name: aSymbol
]
