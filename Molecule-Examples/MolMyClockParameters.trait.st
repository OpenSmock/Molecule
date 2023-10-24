"
I define all the parameters provided by a clock: here, we have just the time zone.

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentParameters for more informations about parameters.
"
Trait {
	#name : #MolMyClockParameters,
	#traits : 'MolComponentParameters',
	#classTraits : 'MolComponentParameters classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #parameters }
MolMyClockParameters >> setManualTime: aTime [

	self explicitRequirement
]

{ #category : #parameters }
MolMyClockParameters >> setTimeZone: aTimeZone [

	self explicitRequirement
]
