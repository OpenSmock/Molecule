"
This Type have a wrong writted contract with variables instead of Traits
"
Trait {
	#name : 'MolDirtyType',
	#classInstVars : [
		'anInstanceVariable'
	],
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : 'Molecule-Tests-Resources - Contracts',
	#package : 'Molecule-Tests',
	#tag : 'Resources - Contracts'
}

{ #category : 'accessing - events' }
MolDirtyType classSide >> consumedComponentEvents [

	<componentContract>
	^ { anInstanceVariable }
]

{ #category : 'accessing - events' }
MolDirtyType classSide >> producedComponentEvents [
	<componentContract>
	^ {anInstanceVariable} 
]

{ #category : 'accessing - parameters' }
MolDirtyType classSide >> providedComponentParameters [
	<componentContract>
	^ {anInstanceVariable} 
]

{ #category : 'accessing - services' }
MolDirtyType classSide >> providedComponentServices [
	<componentContract>
	^ {anInstanceVariable} 
]

{ #category : 'accessing - parameters' }
MolDirtyType classSide >> usedComponentParameters [
	<componentContract>
	^ {anInstanceVariable} 
]

{ #category : 'accessing - services' }
MolDirtyType classSide >> usedComponentServices [
	<componentContract>
	^ {anInstanceVariable}
]
