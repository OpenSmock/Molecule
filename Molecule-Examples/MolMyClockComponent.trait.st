"
I define a MyClockComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I consume MyGlobalTimeEvents, produce MyLocalTimeEvents, provide MyClockParameters and MyClockServices, and MyServerTimeServices.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyClockComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : 'Molecule-Examples-Clock System Example'
}

{ #category : #'accessing - events' }
MolMyClockComponent classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolMyGlobalTimeEvents } 
]

{ #category : #'accessing - events' }
MolMyClockComponent classSide >> producedComponentEvents [
<componentContract>		
	^{ MolMyLocalTimeEvents }
]

{ #category : #'accessing - parameters' }
MolMyClockComponent classSide >> providedComponentParameters [
<componentContract>		
	^{ MolMyClockParameters }
]

{ #category : #'accessing - services' }
MolMyClockComponent classSide >> providedComponentServices [
<componentContract>	
	^{ MolMyClockServices } 
]

{ #category : #'accessing - services' }
MolMyClockComponent classSide >> usedComponentServices [
<componentContract>	
	^{ MolMyServerTimeServices }
]
