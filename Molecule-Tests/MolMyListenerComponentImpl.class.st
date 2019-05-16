"
I am an exemple of event listener. When I am activated, I subscribe myself to MyStateChangeEvents. When I receive a MyStateChangeEvents, I change my internal state (maintenance, operational, failure...).

When I am passivate, I stop to listen events. So I can not change my internal state.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyListenerComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMyListenerComponent + MolMyStateChangeEvents',
	#classTraits : 'MolMyListenerComponent classTrait + MolMyStateChangeEvents classTrait',
	#instVars : [
		'currentState',
		'failureLevel'
	],
	#category : #'Molecule-Tests-Events Resources'
}

{ #category : #'life cycle' }
MolMyListenerComponentImpl >> componentActivate [

	self getMolMyStateChangeEventsSubscriber subscribe: self.
	"Producers are specified at initialization."
]

{ #category : #'life cycle' }
MolMyListenerComponentImpl >> componentPassivate [

	self getMolMyStateChangeEventsSubscriber ifNotNil: 
		[self getMolMyStateChangeEventsSubscriber unsubscribe: self]
]

{ #category : #accessing }
MolMyListenerComponentImpl >> currentState [

	^ currentState
]

{ #category : #events }
MolMyListenerComponentImpl >> failure: aLevel [

	currentState := #failure.
	failureLevel := aLevel.
]

{ #category : #accessing }
MolMyListenerComponentImpl >> failureLevel [

	^ failureLevel
]

{ #category : #'component accessing' }
MolMyListenerComponentImpl >> getMolMyStateChangeEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolMyStateChangeEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [self error:'Events not found'].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolMyStateChangeEvents named:  eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #events }
MolMyListenerComponentImpl >> maintenance [

	currentState := #maintenance
]

{ #category : #events }
MolMyListenerComponentImpl >> operational [

	currentState := #operational
]
