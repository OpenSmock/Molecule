Trait {
	#name : 'MolCompleteComponentChild',
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : 'Molecule-Tests-Resources - Contracts',
	#package : 'Molecule-Tests',
	#tag : 'Resources - Contracts'
}

{ #category : 'accessing - events' }
MolCompleteComponentChild classSide >> consumedComponentEvents [
	<componentContract>	
	^{ MolUsedChildEvents } 
]

{ #category : 'accessing - events' }
MolCompleteComponentChild classSide >> producedComponentEvents [
	<componentContract>
	^ {MolUsedChildEvents } 
]

{ #category : 'accessing - events' }
MolCompleteComponentChild classSide >> providedComponentParameters [
	<componentContract>		
	^{ MolUsedChildParameters }
]

{ #category : 'accessing - services' }
MolCompleteComponentChild classSide >> providedComponentServices [
	<componentContract>	
	^{ MolUsedChildServices } 
]

{ #category : 'accessing - parameters' }
MolCompleteComponentChild classSide >> usedComponentParameters [
	<componentContract>
	^ {MolUsedChildParameters } 
]

{ #category : 'accessing - services' }
MolCompleteComponentChild classSide >> usedComponentServices [
	<componentContract>
	^ {MolUsedChildServices }
]
