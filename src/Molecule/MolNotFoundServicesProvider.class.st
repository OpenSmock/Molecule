"
I am used when a service provider is not found.
"
Class {
	#name : #MolNotFoundServicesProvider,
	#superclass : #MolNotFoundInterface,
	#traits : 'TMolServicesProvider',
	#classTraits : 'TMolServicesProvider classTrait',
	#category : #'Molecule-Exceptions-NotFound'
}

{ #category : #testing }
MolNotFoundServicesProvider >> isFoundServices [

	^ false
]
