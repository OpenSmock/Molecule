"
I define a MyAlarmComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I consume MyLocalTimeEvents, produce MyAlarmSoundsEvents, and provide MyAlarmParameters.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyAlarmComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #'accessing - events' }
MolMyAlarmComponent classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolMyLocalTimeEvents } 
]

{ #category : #'accessing - events' }
MolMyAlarmComponent classSide >> producedComponentEvents [
<componentContract>		
	^{ MolMyAlarmSoundsEvents }
]

{ #category : #'accessing - events' }
MolMyAlarmComponent classSide >> providedComponentParameters [
<componentContract>		
	^{ MolMyAlarmParameters }
]

{ #category : #'accessing - services' }
MolMyAlarmComponent classSide >> providedComponentServices [
<componentContract>	
	^{ MolMyAlarmActivationServices } 
]
