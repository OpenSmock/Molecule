"
I am used when a service provider is not found.
"
Class {
	#name : #MolNotFoundServicesProvider,
	#superclass : #MolNotFoundInterface,
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #testing }
MolNotFoundServicesProvider >> isFoundServices [

	^ false
]

{ #category : #testing }
MolNotFoundServicesProvider >> isNotFoundServices [

	^ self isFoundServices not
]
