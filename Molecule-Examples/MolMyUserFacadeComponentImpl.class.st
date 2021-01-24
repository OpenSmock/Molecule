"
I am an example of final user of this system. I receive time and alarm events, and can use all services and parameters of the system. I could be an HMI.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyUserFacadeComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMyUserFacadeComponent + MolMyLocalTimeEvents + MolMyAlarmSoundsEvents',
	#classTraits : 'MolMyUserFacadeComponent classTrait + MolMyLocalTimeEvents classTrait + MolMyAlarmSoundsEvents classTrait',
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #'life cycle' }
MolMyUserFacadeComponentImpl >> componentActivate [

	self getMolMyLocalTimeEventsSubscriber subscribe: self.
	self getMolMyAlarmSoundsEventsSubscriber subscribe: self
]

{ #category : #'life cycle' }
MolMyUserFacadeComponentImpl >> componentPassivate [

	self getMolMyLocalTimeEventsSubscriber unsubscribe: self.
	self getMolMyAlarmSoundsEventsSubscriber unsubscribe: self
]

{ #category : #'component accessing' }
MolMyUserFacadeComponentImpl >> getMolMyAlarmActivationServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolMyAlarmActivationServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolMyAlarmActivationServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
MolMyUserFacadeComponentImpl >> getMolMyAlarmParametersProvider [
	| parametersSymbol parametersProvider itf |
	itf := MolMyAlarmParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [^MolNotFoundParametersProvider new interface: itf name: nil].
	parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: MolMyAlarmParameters named: parametersSymbol]. 
	^parametersProvider
]

{ #category : #'component accessing' }
MolMyUserFacadeComponentImpl >> getMolMyAlarmSoundsEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolMyAlarmSoundsEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolMyAlarmSoundsEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolMyUserFacadeComponentImpl >> getMolMyClockParametersProvider [
	| parametersSymbol parametersProvider itf |
	itf := MolMyClockParameters.
	parametersSymbol := self parametersProviders at: itf ifAbsent: [^MolNotFoundParametersProvider new interface: itf name: nil].
	parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: MolMyClockParameters named: parametersSymbol]. 
	^parametersProvider
]

{ #category : #'component accessing' }
MolMyUserFacadeComponentImpl >> getMolMyClockServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolMyClockServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolMyClockServices named: servicesSymbol]. 
	^servicesProvider
]

{ #category : #'component accessing' }
MolMyUserFacadeComponentImpl >> getMolMyLocalTimeEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolMyLocalTimeEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolMyLocalTimeEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #events }
MolMyUserFacadeComponentImpl >> notifyAlarmRing: anAlarm [
	MolUtils log: anAlarm getBell.
]

{ #category : #events }
MolMyUserFacadeComponentImpl >> notifyLocalTime: aLocalTime [

	MolUtils log: self printString, ' hour is ', aLocalTime printString.
]
