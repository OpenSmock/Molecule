"
I define the contract of a component. A contract is all the services, events and parameters that a component provides or uses.

You have to define a contract to create a component, by adding the corresponding traits to methods:
- producedComponentsEvents
- consumedComponentsEvents
- providedComponentServices
- usedComponentServices
- providedComponentParameters
- usedcomponentParameters

See traits ComponentEvents, ComponentServices and ComponentParameters for more informations.

Then, create a component implementation by using AbstractComponentImpl or ComponentImpl. Traits and methods are automatically added by ComponentFactory>defineComponent.
"
Trait {
	#name : 'MolComponentType',
	#category : 'Molecule-Component Contract',
	#package : 'Molecule',
	#tag : 'Component Contract'
}

{ #category : 'actions' }
MolComponentType classSide >> allConsumedEvents [
	| collection |
	collection := Set withAll: self consumedComponentEvents.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s consumedComponentEvents 
		] ].
	^ collection asOrderedCollection
]

{ #category : 'actions' }
MolComponentType classSide >> allProducedEvents [
	| collection |
	collection := Set withAll: self producedComponentEvents.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s producedComponentEvents 
		] ].
	^ collection asOrderedCollection
]

{ #category : 'actions' }
MolComponentType classSide >> allProvidedParameters [
	| collection |
	collection := Set withAll: self providedComponentParameters.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s providedComponentParameters 
		] ].
	^ collection asOrderedCollection 
]

{ #category : 'actions' }
MolComponentType classSide >> allProvidedServices [
	| collection |
	collection := Set withAll: self providedComponentServices.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s providedComponentServices 
		] ].
	^ collection asOrderedCollection 
]

{ #category : 'actions' }
MolComponentType classSide >> allUsedParameters [
	| collection |
	collection := Set withAll: self usedComponentParameters.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s usedComponentParameters 
		] ].
	^ collection asOrderedCollection 
]

{ #category : 'actions' }
MolComponentType classSide >> allUsedServices [
	| collection |
	collection := Set withAll: self usedComponentServices.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s usedComponentServices 
		] ].
	^ collection asOrderedCollection 
]

{ #category : 'accessing - events' }
MolComponentType classSide >> consumedComponentEvents [
	<componentContract>
	^ {}
]

{ #category : 'actions' }
MolComponentType classSide >> isConsumeEvents: anEventsTrait [
	anEventsTrait ifNil:[ ^ false ].
	anEventsTrait isComponentEvents
		ifFalse: [ ^ false ]
		ifTrue: [ ^ self allConsumedEvents includes: anEventsTrait ]
]

{ #category : 'actions' }
MolComponentType classSide >> isProduceEvents: anEventsTrait [
	anEventsTrait ifNil: [ ^ false ].
	anEventsTrait isComponentEvents
		ifFalse: [ ^ false ]
		ifTrue: [ ^ self allProducedEvents includes: anEventsTrait ]
]

{ #category : 'actions' }
MolComponentType classSide >> isProvideParameters: aParametersTrait [
	aParametersTrait ifNil: [ ^false ].
	aParametersTrait isComponentParameters
		ifFalse: [ ^ false ]
		ifTrue: [ ^ self allProvidedParameters includes: aParametersTrait ]
]

{ #category : 'actions' }
MolComponentType classSide >> isProvideServices: aServicesTrait [
	aServicesTrait ifNil: [ ^ false ].
	aServicesTrait isComponentServices
		ifFalse: [ ^ false ]
		ifTrue: [ ^ self allProvidedServices includes: aServicesTrait ]
]

{ #category : 'actions' }
MolComponentType classSide >> isUseParameters: aParametersTrait [
	aParametersTrait ifNil: [ ^ false ].
	aParametersTrait isComponentParameters
		ifFalse: [ ^ false ]
		ifTrue: [ ^ self allUsedParameters includes: aParametersTrait ]
]

{ #category : 'actions' }
MolComponentType classSide >> isUseServices: aServicesTrait [
	aServicesTrait ifNil: [ ^ false ].
	aServicesTrait isComponentServices
		ifFalse: [ ^ false ]
		ifTrue: [ ^ self allUsedServices includes: aServicesTrait ]
]

{ #category : 'accessing - events' }
MolComponentType classSide >> producedComponentEvents [
	<componentContract>
	^ {} 
]

{ #category : 'accessing - parameters' }
MolComponentType classSide >> providedComponentParameters [
	<componentContract>
	^ {} 
]

{ #category : 'accessing - services' }
MolComponentType classSide >> providedComponentServices [
	<componentContract>
	^ {} 
]

{ #category : 'accessing - parameters' }
MolComponentType classSide >> usedComponentParameters [
	<componentContract>
	^ {} 
]

{ #category : 'accessing - services' }
MolComponentType classSide >> usedComponentServices [
	<componentContract>
	^ {}
]
