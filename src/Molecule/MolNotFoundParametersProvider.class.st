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

{ #category : #protocol }
MolNotFoundParametersProvider >> parametersDo: actionBlock ifNone: exceptionBlock [
	"Call the parameters if found with the parameters interface as argument. If none execute an exception block"
	
	exceptionBlock value
]
