"
I represent a Molecule contract on a component that consume this contract.
"
Class {
	#name : #MolRSContractModelTarget,
	#superclass : #MolRSContractModel,
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #testing }
MolRSContractModelTarget >> canBreakOn: aString [ 
	^ self eventClass includesTrait: MolComponentEvents
	
]

{ #category : #'as yet unclassified' }
MolRSContractModelTarget >> rsCornerRadius [
	^ RSCornerRadius new right: 10
]
