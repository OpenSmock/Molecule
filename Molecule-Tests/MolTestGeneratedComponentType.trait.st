Trait {
	#name : #MolTestGeneratedComponentType,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Resources - Generated'
}

{ #category : #'accessing - events' }
MolTestGeneratedComponentType classSide >> consumedComponentEvents [
	<componentContract>
	^ { MolTestGeneratedComponentEvents }
]

{ #category : #'accessing - events' }
MolTestGeneratedComponentType classSide >> producedComponentEvents [
	<componentContract>
	^ { MolTestGeneratedComponentEvents }
]

{ #category : #'accessing - parameters' }
MolTestGeneratedComponentType classSide >> providedComponentParameters [
	<componentContract>
	^ { MolTestGeneratedComponentParameters }
]

{ #category : #'accessing - services' }
MolTestGeneratedComponentType classSide >> providedComponentServices [
	<componentContract>
	^ { MolTestGeneratedComponentServices }
]

{ #category : #'accessing - parameters' }
MolTestGeneratedComponentType classSide >> usedComponentParameters [
	<componentContract>
	^ { MolTestGeneratedComponentParameters }
]

{ #category : #'accessing - services' }
MolTestGeneratedComponentType classSide >> usedComponentServices [
	<componentContract>
	^ { MolTestGeneratedComponentServices }
]
