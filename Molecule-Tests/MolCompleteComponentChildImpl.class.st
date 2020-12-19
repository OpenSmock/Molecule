Class {
	#name : #MolCompleteComponentChildImpl,
	#superclass : #MolCompleteComponentImpl,
	#traits : 'MolCompleteComponentChild + MolUsedChildEvents + MolUsedChildServices + MolUsedChildParameters',
	#classTraits : 'MolCompleteComponentChild classTrait + MolUsedChildEvents classTrait + MolUsedChildServices classTrait + MolUsedChildParameters classTrait',
	#category : #'Molecule-Tests-Services Events Parameters Resources'
}

{ #category : #'component accessing' }
MolCompleteComponentChildImpl >> getMolUsedChildEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolUsedChildEvents.
	eventsSymbol := self eventsSubscribers at: itf  ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolUsedChildEvents named:  eventsSymbol ]. 
	^eventsSubscriber
]
