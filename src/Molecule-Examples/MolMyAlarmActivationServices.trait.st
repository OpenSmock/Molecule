"
I define the services provided by an alarm, to activate and deactivate it. 

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentServices for more informations about services.
"
Trait {
	#name : #MolMyAlarmActivationServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #services }
MolMyAlarmActivationServices >> activate [

	self explicitRequirement
]

{ #category : #services }
MolMyAlarmActivationServices >> deactivate [

	self explicitRequirement
]
