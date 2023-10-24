"
I define all the parameters provided by an alarm clock: alarm time, bell and name.

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentParameters for more informations about parameters.
"
Trait {
	#name : #MolMyAlarmParameters,
	#traits : 'MolComponentParameters',
	#classTraits : 'MolComponentParameters classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #parameters }
MolMyAlarmParameters >> setBell: aBell [

	self explicitRequirement
]

{ #category : #parameters }
MolMyAlarmParameters >> setName: aName [

	self explicitRequirement
]

{ #category : #parameters }
MolMyAlarmParameters >> setTime: aTime [

	self explicitRequirement
]
