"
I define a MyListenerComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I consume MyStateChangeEvents.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyListenerComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Events Resources'
}

{ #category : #'accessing - events' }
MolMyListenerComponent classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolMyStateChangeEvents } 
]
