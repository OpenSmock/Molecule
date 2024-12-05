Class {
	#name : #MolRSContractModelSource,
	#superclass : #MolRSContractModel,
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #'as yet unclassified' }
MolRSContractModelSource >> findTarget [

	self halt.
	^ nil
]

{ #category : #testing }
MolRSContractModelSource >> isContractSource [

	^ true
]

{ #category : #'as yet unclassified' }
MolRSContractModelSource >> rsCornerRadius [

	^ RSCornerRadius new left: 10
]
