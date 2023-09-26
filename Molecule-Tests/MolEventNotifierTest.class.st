"
A MolEventNotifierTest is a test class for testing the behavior of MolEventNotifier
"
Class {
	#name : 'MolEventNotifierTest',
	#superclass : 'TestCase',
	#category : 'Molecule-Tests-Cases',
	#package : 'Molecule-Tests',
	#tag : 'Cases'
}

{ #category : 'test' }
MolEventNotifierTest >> setUp [ 
	
	MolComponentManager cleanUp.
]

{ #category : 'test' }
MolEventNotifierTest >> tearDown [  
	
	MolComponentManager cleanUp.
]

{ #category : 'test' }
MolEventNotifierTest >> testActivate [
	| notifier |
	notifier := MolEventNotifier new.
	notifier activate.
	self assert: notifier isActive.
]

{ #category : 'test' }
MolEventNotifierTest >> testDeactivate [
	| notifier |
	notifier := MolEventNotifier new.
	notifier activate.
	notifier deactivate.
	self assert: notifier isActive not.
]

{ #category : 'test' }
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

{ #category : 'test' }
MolEventNotifierTest >> testDoesNotUnderstandWithoutCorrectDefinition [
	| notifier error |
	notifier := MolEventNotifier new.
	error := nil.
	[notifier event] on: Error do:[ :e | error := e ].
	self assert: (error isKindOf: MessageNotUnderstood).
	
	notifier interface: MolUsedEvents.
	notifier event. "Make a log but not raised an error"
]

{ #category : 'test' }
MolEventNotifierTest >> testInitialize [
	| notifier |
	notifier := MolEventNotifier new.
	self assert: notifier interface isNil.
	self assert: notifier originator isNil.
	self assert: notifier isActive equals: false.
]

{ #category : 'test' }
MolEventNotifierTest >> testInterfaceOriginator [
	| notifier originator |
	originator := MolCompleteComponentImpl new.
	notifier := MolEventNotifier interface: MolUsedEvents originator: originator.
	self assert: notifier interface identicalTo: MolUsedEvents.
	self assert: notifier originator identicalTo: originator.
	self assert: notifier isActive equals: false.
]

{ #category : 'test' }
MolEventNotifierTest >> testIsNotFoundEventsNotifier [
	| notifier |
	notifier := MolEventNotifier new.
	self assert: notifier isNotFoundEventsNotifier not.
]

{ #category : 'test' }
MolEventNotifierTest >> testRelease [
	| notifier originator |
	originator := MolCompleteComponentImpl new.
	notifier := MolEventNotifier interface: MolUsedEvents originator: originator.
	notifier activate.
	
	notifier release.
	self assert: notifier interface isNil.
	self assert: notifier originator isNil.
	self assert: notifier isActive equals: false.
]
