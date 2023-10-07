"
I am an exemple of warner. I can send StateChange events with my notifier. Care, I send event when I am not activated.  

You can force me to be quiet, by using instance variable and methods activateComponent and passivateComponent.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyWarnerComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMyWarnerComponent',
	#classTraits : 'MolMyWarnerComponent classTrait',
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #event }
MolMyWarnerComponentImpl >> failureEvent [

	self getMolMyStateChangeEventsNotifier failure: (1 to: 5) atRandom
]

{ #category : #'component accessing' }
MolMyWarnerComponentImpl >> getMolMyStateChangeEventsNotifier [
	^self eventsNotifiers at: MolMyStateChangeEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolMyStateChangeEvents name: nil].
]

{ #category : #event }
MolMyWarnerComponentImpl >> maintenanceEvent [

	self getMolMyStateChangeEventsNotifier maintenance
]

{ #category : #event }
MolMyWarnerComponentImpl >> operationalEvent [

	self getMolMyStateChangeEventsNotifier operational
]
