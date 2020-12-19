"
I am an exemple of server time. I send to my subscribers (clock) the UTC time each second. 

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyServerTimeComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMyServerTimeComponent + MolMyServerTimeServices',
	#classTraits : 'MolMyServerTimeComponent classTrait + MolMyServerTimeServices classTrait',
	#instVars : [
		'process'
	],
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #'life cycle' }
MolMyServerTimeComponentImpl >> componentInitialize [

	process := 
		[[ self getMolMyGlobalTimeEventsNotifier notifyGlobalTime: Time nowUTC.
		(Duration seconds: 1) wait ] 
		repeat]
		fork
]

{ #category : #'life cycle' }
MolMyServerTimeComponentImpl >> componentRemove [

	process terminate.
	process := nil.
]

{ #category : #'component accessing' }
MolMyServerTimeComponentImpl >> getMolMyGlobalTimeEventsNotifier [
	^self eventsNotifiers at: MolMyGlobalTimeEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: itf name: nil].
]

{ #category : #services }
MolMyServerTimeComponentImpl >> getServerTime [

	^ Time nowUTC
]
