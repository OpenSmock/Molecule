"
I define a MyUserFacadeComponent. My only function is to implement a component contract, with methods of ComponentType trait.

In my contract, I consume MyLocalTimeEvents and MyAlarmSoundsEvents, and I use MyClockParameters, MyAlarmParameters and MyClockServices.

With my contract, all my implementations will automatically use appropriate traits and receive generated methods.
"
Trait {
	#name : #MolMyUserFacadeComponent,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #'accessing - events' }
MolMyUserFacadeComponent classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolMyLocalTimeEvents . MolMyAlarmSoundsEvents  } 
]

{ #category : #'accessing - services' }
MolMyUserFacadeComponent classSide >> usedComponentParameters [
<componentContract>	
	^{ MolMyClockParameters . MolMyAlarmParameters }
]

{ #category : #'accessing - services' }
MolMyUserFacadeComponent classSide >> usedComponentServices [
<componentContract>	
	^{ MolMyClockServices . MolMyAlarmActivationServices }
]
