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
	^self consumedComponentEvents.
]

{ #category : #actions }
MolComponentType classSide >> allProducedEvents [
	^self producedComponentEvents.
]

{ #category : #actions }
MolComponentType classSide >> allRequiredParameters [
	^self usedComponentParameters.
]

{ #category : #actions }
MolComponentType classSide >> allRequiredServices [
	^self usedComponentServices.
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
		ifTrue: [^ self providedComponentParameters includes: aParametersTrait].
]

{ #category : #actions }
MolComponentType classSide >> isProvideServices: aServicesTrait [
	(aServicesTrait traitComposition allTraits includes: MolComponentServices )
		ifFalse: [^ false]
		ifTrue: [^ self providedComponentServices includes: aServicesTrait].
]

{ #category : #'accessing - events' }
MolComponentType classSide >> producedComponentEvents [
<componentContract>		
	^{ }
]

{ #category : #'accessing - events' }
MolComponentType classSide >> providedComponentParameters [
<componentContract>		
	^{ }
]

{ #category : #'accessing - services' }
MolComponentType classSide >> providedComponentServices [
<componentContract>	
	^{ } 
]

{ #category : #'accessing - services' }
MolComponentType classSide >> usedComponentParameters [
<componentContract>	
	^{ }
]

{ #category : #'accessing - services' }
MolComponentType classSide >> usedComponentServices [
<componentContract>	
	^{ }
]
