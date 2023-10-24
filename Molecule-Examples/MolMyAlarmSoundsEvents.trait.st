"
I warn my subscribers when my alarm clock sounds.

My consumers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentEvents for more informations about events.
"
Trait {
	#name : #MolMyAlarmSoundsEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #events }
MolMyAlarmSoundsEvents >> notifyAlarmRing: anAlarm [

	self explicitRequirement
]
