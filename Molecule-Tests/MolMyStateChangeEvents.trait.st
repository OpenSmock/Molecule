"
I define StateChange events. A state change can take 3 alternatives, so I implement 3 methods. 

My consumers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentEvents for more informations about events.
"
Trait {
	#name : #MolMyStateChangeEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'Molecule-Tests-Events Resources'
}

{ #category : #events }
MolMyStateChangeEvents >> failure: aLevel [

	^ self explicitRequirement
]

{ #category : #events }
MolMyStateChangeEvents >> maintenance [

	^ self explicitRequirement
]

{ #category : #events }
MolMyStateChangeEvents >> operational [

	^ self explicitRequirement
]
