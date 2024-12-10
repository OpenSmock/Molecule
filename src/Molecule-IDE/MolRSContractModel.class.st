Class {
	#name : #MolRSContractModel,
	#superclass : #Object,
	#instVars : [
		'component',
		'name',
		'eventClass',
		'color'
	],
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #comparing }
MolRSContractModel >> <= aMolRSContractModel [

	^ self eventClass name < aMolRSContractModel eventClass name
]

{ #category : #accessing }
MolRSContractModel >> color [

	^ color
]

{ #category : #accessing }
MolRSContractModel >> color: anObject [

	color := anObject
]

{ #category : #accessing }
MolRSContractModel >> component [

	^ component
]

{ #category : #accessing }
MolRSContractModel >> component: anObject [

	component := anObject
]

{ #category : #accessing }
MolRSContractModel >> eventClass [

	^ eventClass
]

{ #category : #accessing }
MolRSContractModel >> eventClass: anObject [

	eventClass := anObject
]

{ #category : #testing }
MolRSContractModel >> isContractSource [

	^ false
]

{ #category : #accessing }
MolRSContractModel >> name [

	^ name
]

{ #category : #accessing }
MolRSContractModel >> name: anObject [

	name := anObject
]

{ #category : #'as yet unclassified' }
MolRSContractModel >> rsCornerRadius [

	^ self shouldBeImplemented
]
