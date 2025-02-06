"
I represent a Molecule contract on a component that provide this contract.
"
Class {
	#name : #MolRSContractModelSource,
	#superclass : #MolRSContractModel,
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #testing }
MolRSContractModelSource >> isContractSource [

	^ true
]

{ #category : #testing }
MolRSContractModelSource >> shouldBreakOnCall [

	^ (self eventClass includesTrait: MolComponentServices) or: [
		  self eventClass includesTrait: MolComponentParameters ]
]
