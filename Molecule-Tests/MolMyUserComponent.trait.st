"
I define a MyUserComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I use MyTableServices.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyUserComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Services Resources'
}

{ #category : #'accessing - services' }
MolMyUserComponent classSide >> usedComponentServices [
<componentContract>	
	^{ MolMyTableServices }
]
