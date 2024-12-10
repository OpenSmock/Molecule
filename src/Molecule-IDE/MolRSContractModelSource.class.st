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

{ #category : #'as yet unclassified' }
MolRSContractModelSource >> rsCornerRadius [

	^ RSCornerRadius new left: 10
]
