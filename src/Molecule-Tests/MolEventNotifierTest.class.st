"
A MolEventNotifierTest is a test class for testing the behavior of MolEventNotifier
"
Class {
	#name : #MolEventNotifierTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #running }
MolEventNotifierTest >> setUp [

	super setUp.

	MolComponentManager cleanUp
]

{ #category : #running }
MolEventNotifierTest >> tearDown [

	MolComponentManager cleanUp.

	super tearDown
]

{ #category : #tests }
MolEventNotifierTest >> testActivate [
	| notifier |
	notifier := MolEventNotifier new.
	notifier activate.
	self assert: notifier isActive.
]

{ #category : #tests }
MolEventNotifierTest >> testDeactivate [
	| notifier |
	notifier := MolEventNotifier new.
	notifier activate.
	notifier deactivate.
	self assert: notifier isActive not.
]

{ #category : #tests }
MolEventNotifierTest >> testDoesNotUnderstand [
	| originator notifier error |
	originator := MolCompleteComponentImpl new.
	notifier := MolEventNotifier interface: MolUsedEvents originator: originator.
	
	notifier event.
	
	"MolUsedEvent>>subEvent not exists"
	error := nil.
	[notifier subEvent] on: Error do:[ :e | error := e ].
	self assert: (error isKindOf: MessageNotUnderstood).
]

{ #category : #tests }
MolEventNotifierTest >> testDoesNotUnderstandWithoutCorrectDefinition [
	| notifier error |
	notifier := MolEventNotifier new.
	error := nil.
	[notifier event] on: Error do:[ :e | error := e ].
	self assert: (error isKindOf: MessageNotUnderstood).
	
	notifier interface: MolUsedEvents.
	notifier event. "Make a log but not raised an error"
]

{ #category : #tests }
MolEventNotifierTest >> testInitialize [

	| notifier |
	notifier := MolEventNotifier new.
	self assert: notifier interface isNil.
	self assert: notifier originator isNil.
	self deny: notifier isActive
]

{ #category : #tests }
MolEventNotifierTest >> testInterfaceOriginator [

	| notifier originator |
	originator := MolCompleteComponentImpl new.
	notifier := MolEventNotifier
		            interface: MolUsedEvents
		            originator: originator.
	self assert: notifier interface identicalTo: MolUsedEvents.
	self assert: notifier originator identicalTo: originator.
	self deny: notifier isActive
]

{ #category : #tests }
MolEventNotifierTest >> testIsNotFoundEventsNotifier [
	| notifier |
	notifier := MolEventNotifier new.
	self assert: notifier isNotFoundEventsNotifier not.
]

{ #category : #tests }
MolEventNotifierTest >> testRelease [

	| notifier originator error |
	originator := MolCompleteComponentImpl new.
	notifier := MolEventNotifier
		            interface: MolUsedEvents
		            originator: originator.
	notifier activate.

	notifier release.
	self assert: notifier originator isNil.
	self deny: notifier isActive.
	
	"try to send an event when release: do nothing"
	notifier event.
	
	"MolUsedEvent>>subEvent not exists: continue to raise not understood message to identify call problems"
	error := nil.
	[notifier subEvent] on: Error do:[ :e | error := e ].
	self assert: (error isKindOf: MessageNotUnderstood).
]
