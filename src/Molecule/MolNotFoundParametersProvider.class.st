"
I am used when a parameters provider is not found.
"
Class {
	#name : #MolNotFoundParametersProvider,
	#superclass : #MolNotFoundInterface,
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #testing }
MolNotFoundParametersProvider >> isFoundParameters [

	^ false
]

{ #category : #testing }
MolNotFoundParametersProvider >> isNotFoundParameters [

	^ self isFoundParameters not
]
