"
I define a MyClientComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I use MySocketParameters and MySocketServices.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyClientComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Tests-Resources - Contracts'
}

{ #category : #'accessing - parameters' }
MolMyClientComponent classSide >> usedComponentParameters [
<componentContract>	
	^{ MolMySocketParameters }
]

{ #category : #'accessing - services' }
MolMyClientComponent classSide >> usedComponentServices [
<componentContract>	
	^{ MolMySocketServices }
]
