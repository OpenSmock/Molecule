"
I am used when a parameters provider is not found.
"
Class {
	#name : #MolNotFoundParametersProvider,
	#superclass : #MolNotFoundInterface,
	#traits : 'TMolParametersProvider',
	#classTraits : 'TMolParametersProvider classTrait',
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #testing }
MolNotFoundParametersProvider >> isFoundParameters [

	^ false
]
