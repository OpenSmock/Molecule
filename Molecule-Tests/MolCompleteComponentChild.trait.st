Trait {
	#name : #MolCompleteComponentChild,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Services Events Parameters Resources'
}

{ #category : #'accessing - events' }
MolCompleteComponentChild classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolUsedChildEvents } 
]

{ #category : #'accessing - events' }
MolCompleteComponentChild classSide >> providedComponentParameters [
<componentContract>		
	^{ MolUsedChildParameters }
]

{ #category : #'accessing - services' }
MolCompleteComponentChild classSide >> providedComponentServices [
<componentContract>	
	^{ MolUsedChildServices } 
]
