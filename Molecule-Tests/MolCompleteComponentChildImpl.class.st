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
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [self error:'Events not found'].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolUsedChildEvents named:  eventsSymbol ]. 
	^eventsSubscriber
]
