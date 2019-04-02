"
I am used for testing.

/!\ DO NOT :
- consumed & produced the same events;
- provided & used the same services;
- provided & used the same parameters.
"
Trait {
	#name : #MolCompleteComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests'
}

{ #category : #'accessing - events' }
MolCompleteComponent classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolUsedEvents } 
]

{ #category : #'accessing - events' }
MolCompleteComponent classSide >> producedComponentEvents [
<componentContract>		
	^{ MolUsedEvents }
]

{ #category : #'accessing - events' }
MolCompleteComponent classSide >> providedComponentParameters [
<componentContract>		
	^{ MolUsedParameters }
]

{ #category : #'accessing - services' }
MolCompleteComponent classSide >> providedComponentServices [
<componentContract>	
	^{ MolUsedServices } 
]

{ #category : #'accessing - services' }
MolCompleteComponent classSide >> usedComponentParameters [
<componentContract>	
	^{ MolUsedParameters }
]

{ #category : #'accessing - services' }
MolCompleteComponent classSide >> usedComponentServices [
<componentContract>	
	^{ MolUsedServices }
]
