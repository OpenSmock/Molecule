"
I notify my subscribers of the UTC time, each second.

My consumers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentEvents for more informations about events.
"
Trait {
	#name : 'MolMyGlobalTimeEvents',
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : 'Molecule-Examples-Clock System Example',
	#package : 'Molecule-Examples',
	#tag : 'Clock System Example'
}

{ #category : 'events' }
MolMyGlobalTimeEvents >> notifyGlobalTime: aGlobalTime [

	self explicitRequirement
]
