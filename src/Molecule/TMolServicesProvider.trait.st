Trait {
	#name : #TMolServicesProvider,
	#category : #'Molecule-Component Implementation'
}

{ #category : #testing }
TMolServicesProvider >> isFoundServices [

	self explicitRequirement
]

{ #category : #testing }
TMolServicesProvider >> isNotFoundServices [

	^ self isFoundServices not
]
