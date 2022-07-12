"
I define a MyWarnerComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I produce MyStateChangeEvents.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyWarnerComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Resources - Contracts'
}

{ #category : #'accessing - events' }
MolMyWarnerComponent classSide >> producedComponentEvents [
<componentContract>		
	^{ MolMyStateChangeEvents }
]
