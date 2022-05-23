"
I define all the services provided by a table component. Some of these services are not used in the tests, there are examples.

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentServices for more informations about services.
"
Trait {
	#name : #MolMyTableServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'Molecule-Tests-Resources - Contracts'
}

{ #category : #services }
MolMyTableServices >> getContent [

	^ self explicitRequirement
]

{ #category : #services }
MolMyTableServices >> getContentAtRow: aRowNumber [

	^ self explicitRequirement
]

{ #category : #services }
MolMyTableServices >> nbOfColumns [

	^ 3
]

{ #category : #services }
MolMyTableServices >> nbOfRows [

	^ self explicitRequirement
]
