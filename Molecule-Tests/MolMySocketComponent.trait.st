"
I define a MySocketComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I provide MySocketServices and MySocketParameters.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMySocketComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Parameters Resources'
}

{ #category : #'accessing - parameters' }
MolMySocketComponent classSide >> providedComponentParameters [
<componentContract>		
	^{ MolMySocketParameters }
]

{ #category : #'accessing - services' }
MolMySocketComponent classSide >> providedComponentServices [
<componentContract>	
	^{ MolMySocketServices } 
]
