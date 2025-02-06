"
I represent a Molecule contract on a component that consume this contract.
"
Class {
	#name : #MolRSContractModelTarget,
	#superclass : #MolRSContractModel,
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #testing }
MolRSContractModelTarget >> isContractSource [

	^ false
]

{ #category : #testing }
MolRSContractModelTarget >> shouldBreakOnCall [

	^ self eventClass includesTrait: MolComponentEvents
]
