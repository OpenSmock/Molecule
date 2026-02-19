"
This component send an event in a forked thread
"
Class {
	#name : #MolCompleteComponentForkedImpl,
	#superclass : #MolCompleteComponentImpl,
	#instVars : [
		'service'
	],
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #'life cycle' }
MolCompleteComponentForkedImpl >> componentActivate [

	super componentActivate.

	self startEventSending
]

{ #category : #'life cycle' }
MolCompleteComponentForkedImpl >> componentPassivate [

	self stopEventSending.

	super componentPassivate
]

{ #category : #private }
MolCompleteComponentForkedImpl >> doEventSending [

	| notifier |
	notifier := self getMolUsedEventsNotifier.

	"simulate a processing time here"
	100 milliSecond wait.

	notifier event
]

{ #category : #private }
MolCompleteComponentForkedImpl >> startEventSending [

	service := TKTParameterizableService new
		           step: [ self doEventSending ];
		           name: 'Molecule Test - sending event';
		           stepDelay: 50 milliSecond.

	service start
]

{ #category : #private }
MolCompleteComponentForkedImpl >> stopEventSending [

	service stop
]

{ #category : #accessing }
MolCompleteComponentForkedImpl >> thread [

	^ service
]
