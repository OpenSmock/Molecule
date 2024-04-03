Trait {
	#name : 'TMolParametersProvider',
	#category : 'Molecule-Component Implementation',
	#package : 'Molecule',
	#tag : 'Component Implementation'
}

{ #category : 'testing' }
TMolParametersProvider >> isFoundParameters [

	self explicitRequirement 
]

{ #category : 'testing' }
TMolParametersProvider >> isNotFoundParameters [

	^ self isFoundParameters not
]

{ #category : 'protocol' }
TMolParametersProvider >> parametersDo: actionBlock ifNone: exceptionBlock [
	"Call the parameters if found with the parameters interface as argument. If none execute an exception block"
	
	self explicitRequirement 
]
