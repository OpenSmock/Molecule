"
This Type have a wrong writted contract with variables instead of Traits
"
Trait {
	#name : #MolDirtyType,
	#classInstVars : [
		'anInstanceVariable'
	],
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Resources - Contracts'
}

{ #category : #'accessing - events' }
MolDirtyType classSide >> consumedComponentEvents [

	<componentContract>
	^ { anInstanceVariable }
]
