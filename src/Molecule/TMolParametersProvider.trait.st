Trait {
	#name : #TMolParametersProvider,
	#category : #'Molecule-Component Implementation'
}

{ #category : #testing }
TMolParametersProvider >> isFoundParameters [

	self explicitRequirement 
]

{ #category : #testing }
TMolParametersProvider >> isNotFoundParameters [

	^ self isFoundParameters not
]
