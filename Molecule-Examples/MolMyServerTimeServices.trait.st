"
I define all the services provided by server time composant.  A clock needs to know the UTC hour to initialize itself.

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentServices for more informations about services.
"
Trait {
	#name : #MolMyServerTimeServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #services }
MolMyServerTimeServices >> getServerTime [

	^ self explicitRequirement
]
