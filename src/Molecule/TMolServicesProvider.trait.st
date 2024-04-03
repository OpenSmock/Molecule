Trait {
	#name : 'TMolServicesProvider',
	#category : 'Molecule-Component Implementation',
	#package : 'Molecule',
	#tag : 'Component Implementation'
}

{ #category : 'testing' }
TMolServicesProvider >> isFoundServices [

	self explicitRequirement
]

{ #category : 'testing' }
TMolServicesProvider >> isNotFoundServices [

	^ self isFoundServices not
]

{ #category : 'protocol' }
TMolServicesProvider >> servicesDo: actionBlock ifNone: exceptionBlock [
	"Call the services if found with the services interface as argument. If none execute an exception block"
	
	self explicitRequirement 
]
