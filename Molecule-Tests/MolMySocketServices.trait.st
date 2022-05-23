"
I define all the services provided by a socket component. Some of these services are not used in the tests, there are examples.

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentServices for more informations about services.
"
Trait {
	#name : #MolMySocketServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'Molecule-Tests-Resources - Contracts'
}

{ #category : #services }
MolMySocketServices >> connect [

	self explicitRequirement
]

{ #category : #services }
MolMySocketServices >> disconnect [

	self explicitRequirement
]

{ #category : #services }
MolMySocketServices >> receive: aMessage [

	self explicitRequirement
]

{ #category : #services }
MolMySocketServices >> send: aMessage [

	self explicitRequirement
]
