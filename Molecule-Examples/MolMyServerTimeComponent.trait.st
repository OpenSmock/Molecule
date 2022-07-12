"
I define a MyServerTimeComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I produce MyGlobalTimeEvents, and provide  MyServerTimeServices.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyServerTimeComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #'accessing - events' }
MolMyServerTimeComponent classSide >> producedComponentEvents [
<componentContract>		
	^{ MolMyGlobalTimeEvents }
]

{ #category : #'accessing - services' }
MolMyServerTimeComponent classSide >> providedComponentServices [
<componentContract>	
	^{ MolMyServerTimeServices } 
]
