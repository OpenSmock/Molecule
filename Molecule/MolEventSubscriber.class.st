"
I am responsable for subscribe event consumers to event providers.
"
Class {
	#name : #MolEventSubscriber,
	#superclass : #Object,
	#instVars : [
		'events',
		'originators',
		'originatorsLinks',
		'observersConnection',
		'mutex'
	],
	#category : #'Molecule-Core'
}

{ #category : #constructor }
MolEventSubscriber class >> events: aComponentEvents originators: aSubscribersList [
	| eventSubscriber |
	eventSubscriber := self new.
	eventSubscriber events: aComponentEvents originators: aSubscribersList.
	^ eventSubscriber
]

{ #category : #originators }
MolEventSubscriber >> addOriginator: aComponent [
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ self ].
	(self includesOriginator: aComponent) ifTrue: [ ^ self ].
	self originators add: aComponent.
	aComponent when: #removeComponent send: #removeOriginator: to: self.
]

{ #category : #originators }
MolEventSubscriber >> addOriginators: aComponentList [
	aComponentList ifNil:[ ^ self ].
	aComponentList do: [:e | self addOriginator: e]
]

{ #category : #private }
MolEventSubscriber >> connectAllOriginatorsTo: aComponent [
	self mutex criticalReleasingOnError:[ | set |
		set := self observersConnection at: aComponent ifAbsentPut: [Set new].
		self getOriginatorsConnectedKeys do: [ :e |
			(set includes: e) ifFalse:[ 
				set add: e.
				self connectOriginator: e to: aComponent.
			].
		].	
	].
]

{ #category : #private }
MolEventSubscriber >> connectOriginator: componentName to: aComponent [
	"Connect a component to event pipeline"
	self events allSelectors do: [ :event | | originator |
		originator := self originatorsLinks at: componentName.
		originator when: event send: event to: aComponent.
	].
]

{ #category : #private }
MolEventSubscriber >> disconnectAllOriginatorsFrom: aComponent [
	self mutex criticalReleasingOnError: 
			[| set | set := self observersConnection at: aComponent ifAbsent: [nil].
			set ifNotNil:[self getOriginatorsConnectedKeys do: 
					[:cori |
					(set includes: cori)
						ifTrue: 
							[set remove: cori.
							self disconnectOriginator: cori from: aComponent]]].
		
		self observersConnection removeKey: aComponent ifAbsent:[nil].
		
	].
]

{ #category : #private }
MolEventSubscriber >> disconnectOriginator: componentName from: anObserver [
	"private method, do not use directly"
	self events allSelectors do: 
			[:evt | | originator |
			originator := self originatorsLinks at: componentName.
			originator ifNil: [ ^ self error: 'Component originator is nil' ].
			originator removeActionsWithReceiver: anObserver forEvent: evt]
]

{ #category : #accessing }
MolEventSubscriber >> events [
	^ events
]

{ #category : #'initialize-release' }
MolEventSubscriber >> events: aComponentEvents originators: aComponentList [
	(aComponentEvents isNil and:[aComponentEvents isTrait not and:[aComponentEvents isComponentEvents not]]) ifTrue:[ ^ self ].
	events := aComponentEvents.
	aComponentList ifNil:[ ^ self ].
	aComponentList do: [ :c | self addOriginator: c].
]

{ #category : #private }
MolEventSubscriber >> getObserversFrom: aComponent [
	| observers |
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ nil ].
	observers := OrderedCollection new.
	self observersConnection
		keysDo: [ :e | 
			(self observersConnection at: e)
				ifNotNil: [ (self observersConnection includes: aComponent componentName)
						ifTrue: [ observers add: e ] ] ].
	^ observers 
]

{ #category : #private }
MolEventSubscriber >> getOriginatorsConnectedKeys [
	^ self originatorsLinks keys reject: [ :e | (self originatorsLinks at: e) isNil ]
]

{ #category : #originators }
MolEventSubscriber >> includesOriginator: aComponent [
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ false ].
	^ self originators includes: aComponent
]

{ #category : #testing }
MolEventSubscriber >> isAllOriginatorsLinked [
	"All is empty"
	(self originatorsLinks isEmpty and:[self originators isEmpty]) ifTrue:[ ^ true ].
	"Originators are presents but links is empty"
	self originatorsLinks isEmpty ifTrue:[ ^ false ].

	^ (self originatorsLinks values includes: nil) not
]

{ #category : #testing }
MolEventSubscriber >> isNotFoundEventsSubscriber [ 
	^false
]

{ #category : #testing }
MolEventSubscriber >> isWaitingForSubscription [
	^ self isAllOriginatorsLinked not
		or: [ (self observersConnection values
				select:
					[ :s | s ifNil: [ true ] ifNotNil: [ s size ~= self originators size ] ])
				isNotEmpty ]
]

{ #category : #private }
MolEventSubscriber >> linkOriginator: aComponent [
	| originator |
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ self ].

	"Originator link is nil when not linked"
	originator := self originatorsLinks at: aComponent componentName ifPresent:[ :e |
		e = aComponent ifTrue:["Already linked" ^ self ].
	] ifAbsent: [ #none ].

	originator = #none ifTrue: [ "Not existing originator" ^ self ].

	"Link the originator with component injection"
	self originatorsLinks at: aComponent componentName put: aComponent
]

{ #category : #private }
MolEventSubscriber >> linkOriginators: aComponentList [
	aComponentList ifNil:[ ^ self ].
	aComponentList do: [:e | self linkOriginator: e]
]

{ #category : #accessing }
MolEventSubscriber >> mutex [
	mutex ifNil: [ mutex := Semaphore forMutualExclusion ].
	^ mutex
]

{ #category : #accessing }
MolEventSubscriber >> observersConnection [
	observersConnection ifNil: [ observersConnection := Dictionary new ].
	^ observersConnection
]

{ #category : #accessing }
MolEventSubscriber >> originators [
	originators ifNil: [ originators := OrderedCollection new ].
	^ originators
]

{ #category : #accessing }
MolEventSubscriber >> originatorsLinks [
	originatorsLinks ifNil: [originatorsLinks := Dictionary new].
	^originatorsLinks
]

{ #category : #'initialize-release' }
MolEventSubscriber >> release [
	events := nil.
	originators := nil.
	originatorsLinks := nil.
	observersConnection := nil.
	mutex := nil.
	super release.
]

{ #category : #originators }
MolEventSubscriber >> removeOriginator: aComponent [
	| observersList |
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ self ].
	(self includesOriginator: aComponent) ifFalse:[ ^ self ].

	self originators remove: aComponent. 
	observersList := self getObserversFrom: aComponent.
	observersList do: [ :comp | | newObserversSet|
		self flag:'PLA : on ne passe pas ici'.
		self disconnectOriginator: aComponent componentName from: comp.
		self observersConnection at: comp put: nil.
		"newObserversSet := self observersConnection at: aComponent ifAbsent:[ nil ].
		newObserversSet ifNotNil:[
			newObserversSet remove: comp componentName ifAbsent:[ nil ].
			self observersConnection at: comp put: newObserversSet.
		]."
	].
]

{ #category : #API }
MolEventSubscriber >> subscribe: aComponent [
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ self ].
	self connectAllOriginatorsTo: aComponent
]

{ #category : #private }
MolEventSubscriber >> subscribeAllWaiting [
	self observersConnection keysDo: [ :comp | self connectAllOriginatorsTo: comp ]
]

{ #category : #private }
MolEventSubscriber >> unlinkOriginator: aComponent [
	| originator |
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ self ].
	
	originator := self originatorsLinks at: aComponent componentName ifPresent:[ :e |
		e ifNil:["Already unlink" ^ self ].	
	] ifAbsent: [ #none ].

	originator = #none ifTrue: [ ^ self ].
	"Originator link is nil when not linked"
	self originatorsLinks at: aComponent componentName put: nil
]

{ #category : #API }
MolEventSubscriber >> unsubscribe: aComponent [
	(aComponent isNil or:[aComponent isComponent not]) ifTrue:[ ^ self ].
	self disconnectAllOriginatorsFrom: aComponent.
]
