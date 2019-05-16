"
I am an exemple of alarm clock. I have a time, a bell, a name, and I sound (MyAlarmSoundsEvents) when it is time. I receive time from a clock component (MyLocalTimeEvents).

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyAlarmComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMyAlarmComponent + MolMyLocalTimeEvents + MolMyAlarmParameters + MolMyAlarmActivationServices',
	#classTraits : 'MolMyAlarmComponent classTrait + MolMyLocalTimeEvents classTrait + MolMyAlarmParameters classTrait + MolMyAlarmActivationServices classTrait',
	#instVars : [
		'name',
		'time',
		'bell',
		'activate'
	],
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #services }
MolMyAlarmComponentImpl >> activate [

	activate := true.
]

{ #category : #'life cycle' }
MolMyAlarmComponentImpl >> componentActivate [

	self getMolMyLocalTimeEventsSubscriber subscribe: self.
]

{ #category : #'life cycle' }
MolMyAlarmComponentImpl >> componentInitialize [
	"Component is initialized with default values"
	name := 'Alarm'.
	time := Time hour: 7 minute: 30 second: 0.
	bell := 'Ring ring'.
	activate := false.
	
	self forEvents: MolMyLocalTimeEvents useProducer: #default.
]

{ #category : #'life cycle' }
MolMyAlarmComponentImpl >> componentPassivate [

	self getMolMyLocalTimeEventsSubscriber unsubscribe: self.
]

{ #category : #services }
MolMyAlarmComponentImpl >> deactivate [

	activate := false.
]

{ #category : #accessing }
MolMyAlarmComponentImpl >> getBell [

	^ bell
]

{ #category : #'component accessing' }
MolMyAlarmComponentImpl >> getMolMyAlarmSoundsEventsNotifier [
	^self eventsNotifiers at: MolMyAlarmSoundsEvents ifAbsent: [nil]
]

{ #category : #'component accessing' }
MolMyAlarmComponentImpl >> getMolMyLocalTimeEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolMyLocalTimeEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [self error:'Events not found'].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolMyLocalTimeEvents named:  eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #events }
MolMyAlarmComponentImpl >> notifyLocalTime: aTime [

	activate ifTrue: 
		[ aTime = time ifTrue: 
			[ self getMolMyAlarmSoundsEventsNotifier notifyAlarmRing: self ]]
]

{ #category : #parameters }
MolMyAlarmComponentImpl >> setBell: aBell [

	bell := aBell
]

{ #category : #parameters }
MolMyAlarmComponentImpl >> setName: aName [

	name := aName
]

{ #category : #parameters }
MolMyAlarmComponentImpl >> setTime: aTime [

	time := aTime
]
