"
I notify my subscribers of the local time, each second.

My consumers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentEvents for more informations about events.
"
Trait {
	#name : #MolMyLocalTimeEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #events }
MolMyLocalTimeEvents >> notifyLocalTime: aLocalTime [

	self explicitRequirement
]
