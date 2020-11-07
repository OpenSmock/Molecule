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
	#name : #MolComponentType,
	#category : #'Molecule-Core'
}

{ #category : #actions }
MolComponentType classSide >> allConsumedEvents [
	| collection |
	collection := OrderedCollection withAll: self consumedComponentEvents.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s consumedComponentEvents 
		] ].
	^ collection
]

{ #category : #actions }
MolComponentType classSide >> allProducedEvents [
	| collection |
	collection := OrderedCollection withAll: self producedComponentEvents.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s producedComponentEvents 
		] ].
	^ collection
]

{ #category : #actions }
MolComponentType classSide >> allProvidedParameters [
	| collection |
	collection := OrderedCollection withAll: self providedComponentParameters.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s providedComponentParameters 
		] ].
	^ collection
]

{ #category : #actions }
MolComponentType classSide >> allProvidedServices [
	| collection |
	collection := OrderedCollection withAll: self providedComponentServices.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s providedComponentServices 
		] ].
	^ collection
]

{ #category : #actions }
MolComponentType classSide >> allRequiredParameters [
	| collection |
	collection := OrderedCollection withAll: self usedComponentParameters.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s usedComponentParameters 
		] ].
	^ collection
]

{ #category : #actions }
MolComponentType classSide >> allRequiredServices [
	| collection |
	collection := OrderedCollection withAll: self usedComponentServices.
	self allSuperclassesDo: [ :s | 
		(s allTraits includes: MolComponentType) ifTrue: [ 
				collection addAll: s usedComponentServices 
		] ].
	^ collection
]

{ #category : #'accessing - events' }
MolComponentType classSide >> consumedComponentEvents [
<componentContract>	
	^{ } 
]

{ #category : #actions }
MolComponentType classSide >> isProduceEvents: anEventsTrait [
	(anEventsTrait traitComposition allTraits includes: MolComponentEvents)
		ifFalse: [^ false]
		ifTrue: [^ self allProducedEvents includes: anEventsTrait].
]

{ #category : #actions }
MolComponentType classSide >> isProvideParameters: aParametersTrait [
	(aParametersTrait traitComposition allTraits includes: MolComponentParameters)
		ifFalse: [^ false]
		ifTrue: [^ self allProvidedParameters includes: aParametersTrait].
]

{ #category : #actions }
MolComponentType classSide >> isProvideServices: aServicesTrait [
	(aServicesTrait traitComposition allTraits includes: MolComponentServices )
		ifFalse: [^ false]
		ifTrue: [^ self allProvidedServices includes: aServicesTrait].
]

{ #category : #'accessing - events' }
MolComponentType classSide >> producedComponentEvents [
<componentContract>		
	^{ }
]

{ #category : #'accessing - parameters' }
MolComponentType classSide >> providedComponentParameters [
<componentContract>		
	^{ }
]

{ #category : #'accessing - services' }
MolComponentType classSide >> providedComponentServices [
<componentContract>	
	^{ } 
]

{ #category : #'accessing - parameters' }
MolComponentType classSide >> usedComponentParameters [
<componentContract>	
	^{ }
]

{ #category : #'accessing - services' }
MolComponentType classSide >> usedComponentServices [
<componentContract>	
	^{ }
]
