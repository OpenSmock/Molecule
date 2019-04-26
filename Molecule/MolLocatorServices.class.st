"
I am responsible for find components in the system.

See examples of my use in Tests and Examples packages.
"
Class {
	#name : #MolLocatorServices,
	#superclass : #Object,
	#instVars : [
		'eventsSubscribers'
	],
	#category : #'Molecule-Core'
}

{ #category : #accessing }
MolLocatorServices >> eventsSubscribers [
	eventsSubscribers isNil ifTrue: [eventsSubscribers := Dictionary new].
	^ eventsSubscribers
]

{ #category : #accessing }
MolLocatorServices >> eventsSubscribers: aDictionaryOrNil [
	eventsSubscribers := aDictionaryOrNil
]

{ #category : #accessing }
MolLocatorServices >> resolveWaitingSubscribtions: aComponent [
	| eventsKey |

	self eventsSubscribers ifEmpty: [^self].
	
	eventsKey := aComponent class allProducedEvents collect: [ :event | event -> aComponent componentName ].
	
	eventsKey do: [ :eventKey | | eventsList |
		
		eventsList := self eventsSubscribers keys select: [ :key | key key = eventKey key ].
		eventsList := eventsList select: [ :event | 
			event value = eventKey value or: [ event value includes: eventKey value ] 
		].
	
		eventsList := eventsList collect: [ :event | self eventsSubscribers at: event ].
		eventsList do: [ :event |
			event ifNotNil:[
				event isWaitingForSubscription ifTrue:[
						(event getOriginators includes: aComponent) ifFalse:[ 
							event 	addOriginator: aComponent; linkOriginator: aComponent.
						].
						event subscribeAllWaiting.
				]. 
			]. 
		].
	]
]

{ #category : #searching }
MolLocatorServices >> searchEventsSubscriberFor: anEventsTrait [
	^self searchEventsSubscriberFor: anEventsTrait named: #default
]

{ #category : #searching }
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

	events := self eventsSubscribers
		at: itf -> aSymbolOrArrayOfSymbols
		ifAbsentPut: [ MolEventSubscriber new interface: itf originators: subscribers ].
	subscribers do: [ :e | events originatorsLinks at: e componentName put: e ].
	remainingNames do: [ :e | events originatorsLinks at: e put: nil].
	events addOriginators: subscribers.
	
	^ events
]

{ #category : #searching }
MolLocatorServices >> searchParametersProviderFor: aParametersTrait [
	^self searchParametersProviderFor: aParametersTrait named: #default
]

{ #category : #searching }
MolLocatorServices >> searchParametersProviderFor: aParametersTrait named: aSymbol [
	| comps itf |
	
	itf := aParametersTrait value.
	comps := MolComponentManager default homeServices deployedComponents.
	comps keysDo:[:comp | 
		((comp isProvideParameters: itf) and: [(comps at: comp) includesKey: aSymbol]) ifTrue: [
			^(comps at: comp) at: aSymbol
		].
	].
	^MolNotFoundParametersProvider new interface: aParametersTrait name: aSymbol
]

{ #category : #searching }
MolLocatorServices >> searchServicesProviderFor: aServicesTrait [
	^self searchServicesProviderFor: aServicesTrait named: #default
]

{ #category : #searching }
MolLocatorServices >> searchServicesProviderFor: aServicesTrait named: aSymbol [
	| comps itf |
	
	itf := aServicesTrait value.
	comps := MolComponentManager default homeServices deployedComponents.
	comps keysDo: 
			[:comp | 
			((comp isProvideServices: itf) and: [(comps at: comp) includesKey: aSymbol]) 
				ifTrue: [^(comps at: comp) at: aSymbol]].
	^MolNotFoundServicesProvider new interface: aServicesTrait name: aSymbol
]
