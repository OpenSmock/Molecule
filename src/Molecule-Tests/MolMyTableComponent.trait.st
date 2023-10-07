"
I define a MyTableComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I provide MyTableServices.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyTableComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Resources - Contracts'
}

{ #category : #'accessing - services' }
MolMyTableComponent classSide >> providedComponentServices [
<componentContract>	
	^{ MolMyTableServices } 
]
