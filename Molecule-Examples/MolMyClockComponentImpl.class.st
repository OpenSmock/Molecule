"
I am an exemple of clock. I receive a UTC time from a server, and I convert it to a local time. You can decide to switch to a manual use, where you define my time.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyClockComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMyClockComponent + MolMyGlobalTimeEvents + MolMyClockServices + MolMyClockParameters',
	#classTraits : 'MolMyClockComponent classTrait + MolMyGlobalTimeEvents classTrait + MolMyClockServices classTrait + MolMyClockParameters classTrait',
	#instVars : [
		'delta',
		'timeZone',
		'useManualTime'
	],
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #'life cycle' }
MolMyClockComponentImpl >> componentActivate [

	self getMolMyGlobalTimeEventsSubscriber subscribe: self.
]

{ #category : #'life cycle' }
MolMyClockComponentImpl >> componentInitialize [

	useManualTime := false.
	timeZone := TimeZone local.
	delta := Time hour: 0 minute: 0 second: 0.
	
	self forServices: MolMyServerTimeServices useProvider: #default.
	self forEvents: MolMyGlobalTimeEvents useProducer: #default.
]

{ #category : #'life cycle' }
MolMyClockComponentImpl >> componentPassivate [

	self getMolMyGlobalTimeEventsSubscriber unsubscribe: self.
]

{ #category : #'component accessing' }
MolMyClockComponentImpl >> getMolMyGlobalTimeEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolMyGlobalTimeEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolMyGlobalTimeEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolMyClockComponentImpl >> getMolMyLocalTimeEventsNotifier [
	^self eventsNotifiers at: MolMyLocalTimeEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolMyLocalTimeEvents name: nil].
]

{ #category : #'component accessing' }
MolMyClockComponentImpl >> getMolMyServerTimeServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolMyServerTimeServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolMyServerTimeServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #events }
MolMyClockComponentImpl >> notifyGlobalTime: aGlobalTime [
	| localTime |
	localTime := useManualTime
		ifTrue: [ Time
				hour: aGlobalTime hour + delta hour
				minute: aGlobalTime minute + delta minute
				second: aGlobalTime second + delta second ]
		ifFalse: [ Time
				hour: aGlobalTime hour + timeZone offset hours
				minute: aGlobalTime minute + timeZone offset minutes
				second: aGlobalTime second + timeZone offset seconds ].
	self getMolMyLocalTimeEventsNotifier notifyLocalTime: localTime
]

{ #category : #parameters }
MolMyClockComponentImpl >> setManualTime: aTime [

	| globalTime |
	globalTime := self getMolMyServerTimeServicesProvider getServerTime.
	delta := Duration
		days: 0
		hours: (globalTime hour - aTime hour)
		minutes: (globalTime minute - aTime minute)
		seconds: (globalTime second - aTime second)
]

{ #category : #parameters }
MolMyClockComponentImpl >> setTimeZone: aTimeZone [

	timeZone := aTimeZone
]

{ #category : #services }
MolMyClockComponentImpl >> useManualTime: aBoolean [

	useManualTime := aBoolean
]
