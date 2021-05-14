"
This Contract is the same that MolCompleteComponent : same services, parameters and events.
"
Trait {
	#name : #MolCompleteComponent2,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Resources - Contracts'
}

{ #category : #'accessing - events' }
MolCompleteComponent2 classSide >> consumedComponentEvents [
	<componentContract>	
	^{ MolUsedEvents } 
]

{ #category : #'accessing - events' }
MolCompleteComponent2 classSide >> producedComponentEvents [
	<componentContract>		
	^{ MolUsedEvents }
]

{ #category : #'accessing - parameters' }
MolCompleteComponent2 classSide >> providedComponentParameters [
	<componentContract>		
	^{ MolUsedParameters }
]

{ #category : #'accessing - services' }
MolCompleteComponent2 classSide >> providedComponentServices [
	<componentContract>	
	^{ MolUsedServices } 
]

{ #category : #'accessing - parameters' }
MolCompleteComponent2 classSide >> usedComponentParameters [
	<componentContract>	
	^{ MolUsedParameters }
]

{ #category : #'accessing - services' }
MolCompleteComponent2 classSide >> usedComponentServices [
	<componentContract>
	^{ MolUsedServices }
]
