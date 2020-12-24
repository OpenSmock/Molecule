"
I am responsable for subscribe event consumers to event providers.
"
Class {
	#name : #MolEventSubscriber,
	#superclass : #Object,
	#instVars : [
		'interface',
		'originators',
		'originatorsLinks',
		'observersConnection',
		'mutex'
	],
	#category : #'Molecule-Core'
}

{ #category : #accessing }
MolEventSubscriber >> addOriginator: aValue [
	(self getOriginators includes: aValue) ifTrue: [ ^self ].
	self getOriginators add: aValue.
	aValue when: #removeComponent send: #removeOriginator: to: self
]

{ #category : #accessing }
MolEventSubscriber >> addOriginators: aValue [
	aValue do: [:e | self addOriginator: e]
]

{ #category : #private }
MolEventSubscriber >> connectAllOriginatorsTo: anObserver [
	| set |
	self mutex critical: 
			[ set := self observersConnection at: anObserver ifAbsent: [nil].
			set isNil ifTrue:[set := self observersConnection at: anObserver put: Set new].
			self getOriginatorsConnectedKeys do: 
					[:cori |
					(set includes: cori)
						ifFalse: 
							[set add: cori.
							self connectOriginator: cori to: anObserver]]]
]

{ #category : #private }
MolEventSubscriber >> connectOriginator: coriSymbol to: anObserver [
	"private method, do not use directly"
	| originator |
	interface allSelectors do: 
			[:evt |
			originator := self originatorsLinks at: coriSymbol.
			originator isNil ifTrue: [ ^ self error: 'Component originator is nil' ].
			originator when: evt send: evt to: anObserver]
]

{ #category : #private }
MolEventSubscriber >> disconnectAllOriginatorsFrom: anObserver [
	| set |
	self mutex critical: 
			[set := self observersConnection at: anObserver ifAbsent: [nil].
			set isNil ifFalse:[self getOriginatorsConnectedKeys do: 
					[:cori |
					(set includes: cori)
						ifTrue: 
							[set remove: cori.
							self disconnectOriginator: cori from: anObserver]]]]
]

{ #category : #private }
MolEventSubscriber >> disconnectOriginator: coriSymbol from: anObserver [
	"private method, do not use directly"
	interface allSelectors do: 
			[:evt | | originator |
			originator := self originatorsLinks at: coriSymbol.
			originator isNil ifTrue: [ ^ self error: 'Component originator is nil' ].
			originator removeActionsWithReceiver: anObserver forEvent: evt]
]

{ #category : #accessing }
MolEventSubscriber >> getObserversFrom: aComponent [
	| observers |
	observers := OrderedCollection new.
	self observersConnection
		keysDo: [ :e | 
			(self observersConnection at: e)
				ifNotNil: [ (self observersConnection includes: aComponent componentName)
						ifTrue: [ observers add: e ] ] ].
	^ observers 
]

{ #category : #accessing }
MolEventSubscriber >> getOriginators [
	originators isNil ifTrue: [ originators := OrderedCollection new ].
	^ originators
]

{ #category : #private }
MolEventSubscriber >> getOriginatorsConnectedKeys [
	^ self originatorsLinks keys reject: [ :e | (self originatorsLinks at: e) isNil ]
]

{ #category : #accessing }
MolEventSubscriber >> interface: anInterface originators: componentInstances [
	interface := anInterface.
	componentInstances do: [ :o | self addOriginator: o ]
]

{ #category : #testing }
MolEventSubscriber >> isAllOriginatorsConnected [
	^ (self originatorsLinks values includes: nil) not
]

{ #category : #accessing }
MolEventSubscriber >> isNotFoundEventsSubscriber [ 
	^false
]

{ #category : #testing }
MolEventSubscriber >> isWaitingForSubscription [
	^ self isAllOriginatorsConnected not
		or: [ (observersConnection values
				select: [ :s | 
					s isNil
						ifTrue: [ true ]
						ifFalse: [ s size ~= self getOriginators size ] ]) isNotEmpty ]
]

{ #category : #accessing }
MolEventSubscriber >> linkOriginator: aComp [
	| originator |
	originator := self originatorsLinks at: aComp componentName ifAbsent: [ #none ].
	originator = #none ifTrue: [ ^ self ].
	self originatorsLinks at: aComp componentName put: aComp
]

{ #category : #accessing }
MolEventSubscriber >> mutex [
	mutex isNil ifTrue: [ mutex := Semaphore forMutualExclusion ].
	^ mutex
]

{ #category : #accessing }
MolEventSubscriber >> observersConnection [
	observersConnection isNil ifTrue: [ observersConnection := Dictionary new ].
	^ observersConnection
]

{ #category : #accessing }
MolEventSubscriber >> originatorsLinks [
	originatorsLinks isNil ifTrue: [originatorsLinks := Dictionary new].
	^originatorsLinks
]

{ #category : #'initialize-release' }
MolEventSubscriber >> release [
	super release.
	interface := nil.
	originators := nil.
	originatorsLinks := nil.
	observersConnection := nil.
	mutex := nil
]

{ #category : #'event triggering' }
MolEventSubscriber >> removeOriginator: aOriginator [
	| observersList |
	observersList := self getObserversFrom: aOriginator.
	observersList do: [:e |
		self disconnectOriginator: aOriginator componentName from: e.
		self observersConnection at: e put: nil].
]

{ #category : #API }
MolEventSubscriber >> subscribe: anObserver [
	self connectAllOriginatorsTo: anObserver
]

{ #category : #API }
MolEventSubscriber >> subscribeAllWaiting [
	self observersConnection keysDo: [ :comp | self connectAllOriginatorsTo: comp ]
]

{ #category : #API }
MolEventSubscriber >> unsubscribe: anObserver [
	self disconnectAllOriginatorsFrom: anObserver.
	self observersConnection removeKey: anObserver ifAbsent:[nil].
]
