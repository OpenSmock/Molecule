"
I define all the services provided by a clock. Remember that the main difference point between parameters and services is semantic.

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentServices for more informations about services.
"
Trait {
	#name : #MolMyClockServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #services }
MolMyClockServices >> useManualTime: aBoolean [

	self explicitRequirement
]
