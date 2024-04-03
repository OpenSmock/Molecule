"
I am used when a service provider is not found.
"
Class {
	#name : 'MolNotFoundServicesProvider',
	#superclass : 'MolNotFoundInterface',
	#traits : 'TMolServicesProvider',
	#classTraits : 'TMolServicesProvider classTrait',
	#category : 'Molecule-Exceptions-NotFound',
	#package : 'Molecule',
	#tag : 'Exceptions-NotFound'
}

{ #category : 'testing' }
MolNotFoundServicesProvider >> isFoundServices [

	^ false
]

{ #category : 'protocol' }
MolNotFoundServicesProvider >> servicesDo: actionBlock ifNone: exceptionBlock [
	"Call the services if found with the services interface as argument. If none execute an exception block"
	
	exceptionBlock value
]
