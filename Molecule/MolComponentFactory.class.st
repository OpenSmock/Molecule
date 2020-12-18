"
I am used to generate component code.

When a component implementation and its trait type are defined, use method 'defineComponent' to generate automatically missing methods and traits.

Also, when the contract of ComponentType changes, 'defineComponent' is automatically send.
"
Class {
	#name : #MolComponentFactory,
	#superclass : #Object,
	#instVars : [
		'pragmaCollector',
		'isDynamicContractUpdateActivated',
		'dirtyComponentTypes',
		'dirtyComponents'
	],
	#classVars : [
		'Default'
	],
	#category : #'Molecule-Tools'
}

{ #category : #accessing }
MolComponentFactory class >> cleanUp [
	<script: 'self cleanUp'>
	
	Default ifNil: [ ^ self ].
	Default release.
	Default := nil
]

{ #category : #'componentImpl - creation' }
MolComponentFactory class >> createComponentForType: aComponentType named: aSymbol in: aPackageName [

	aComponentType notNil ifTrue:[
		aComponentType isComponentType  ifFalse: [ self error: '[Molecule] Cannot create Component for a no Type object.' ].
	].
		
	self class environment
		at: aSymbol
		ifPresent: [self error:'[Molecule] Do not redefine an existing Component, remove it before.' ].

	OpalCompiler new evaluate:
			'MolAbstractComponentImpl subclass: ' , aSymbol printString
				,
	(aComponentType notNil ifTrue:[	(' 
	uses: ' , aComponentType printString)
	] ifFalse:[''])			,
					'
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''' , aPackageName , ''''.
	
	(self class environment at: aSymbol) defineComponent
]

{ #category : #'componentImpl - creation' }
MolComponentFactory class >> createComponentNamed: aSymbol in: aPackageName [

	self createComponentForType: nil named: aSymbol in: aPackageName
]

{ #category : #accessing }
MolComponentFactory class >> default [
	<script: 'self default'>

	Default ifNil:[ Default := self new ].
	^Default
]

{ #category : #accessing }
MolComponentFactory class >> defineComponent: aComponentType [

	self default defineComponent: aComponentType
 

]

{ #category : #accessing }
MolComponentFactory class >> defineDirtyComponents [

	<script>
	self default defineDirtyComponents
]

{ #category : #'class initialization' }
MolComponentFactory class >> initialize [

	self default
]

{ #category : #'dynamic contract update' }
MolComponentFactory >> activateDynamicContractUpdate [

	self isDynamicContractUpdateActivated ifTrue: [ ^ self ].
	self inform: '[Molecule] Dynamic Contract Update is active'.
	self isDynamicContractUpdateActivated: true
]

{ #category : #'private - code checking' }
MolComponentFactory >> checkUsedTrait: aList in: aComponent [
	| eventAndServices missing |
	
	"check component used traits includes trait list "
	eventAndServices := self collectComponentConnectionTraits: aComponent.
	missing := aList reject: [:e | eventAndServices includes: e].
	missing ifNotEmpty: [self rebuildComponent: aComponent traitsAdding: missing].
	eventAndServices := self collectComponentConnectionTraits: aComponent.

	"bool := false.
	aList do: [:e | (eventAndServices includes: e) ifFalse: [
			bool := UIManager default
								confirm:
									'Used trait is not declared (' , e printString
										, '), do you want to browse class ?']].
	bool ifTrue: [aComponent browse]"
]

{ #category : #'dirty components' }
MolComponentFactory >> collectComponentConnectionTraits: aComponent [

	^aComponent traitComposition allTraits select: [:e | (e traitComposition allTraits includes: MolComponentServices) or: [(e traitComposition allTraits includes: MolComponentEvents) or: [e traitComposition allTraits includes: MolComponentParameters]]].
]

{ #category : #'system annoucements' }
MolComponentFactory >> componentAddedAnnouncement: aClassAddedAnnouncement [
	
	| classOrTraitAdded |
	classOrTraitAdded := aClassAddedAnnouncement classAdded.
	classOrTraitAdded isTrait ifFalse:[self componentChanged: classOrTraitAdded].
]

{ #category : #'system annoucements' }
MolComponentFactory >> componentChanged: aChangedClass [

	aChangedClass isComponent ifTrue:[		
		self isDynamicContractUpdateActivated ifTrue: [ 
			"need to fork the definition because new traits are not already injected here to the component"
			[self defineComponent: aChangedClass] fork. 
		] ifFalse: [ dirtyComponents add: aChangedClass].
	].
]

{ #category : #'system annoucements' }
MolComponentFactory >> componentChangedAnnouncement: aClassModifiedClassDefinitionAnnouncement [

	aClassModifiedClassDefinitionAnnouncement ifNil: [self error: '[Molecule] Error on Component changed notification.'. ^ self].
	self componentChanged: aClassModifiedClassDefinitionAnnouncement newClassDefinition.
]

{ #category : #'system annoucements' }
MolComponentFactory >> contractChanged: aComponentType [
	
	aComponentType ifNil: [self error: '[Molecule] Error on contract changed notification.'. ^ self ].
	aComponentType isTrait ifFalse:["Only Component Type are supported" ^self].

	self isDynamicContractUpdateActivated ifTrue: [ 
		"need to fork the definition because new traits are not already injected here to the component"
		[ self defineComponentTypeImplementors: aComponentType ] fork 
	] ifFalse: [ dirtyComponentTypes add: aComponentType ]
]

{ #category : #'system annoucements' }
MolComponentFactory >> contractChangedAnnouncement: aMessage [
	| aComponentType |
	
	aMessage ifNil: [ self error: '[Molecule] Error on contract changed notification.'. ^ self ].
	aMessage pragma ifNil: [self error: '[Molecule] Error on contract changed notification.'. ^ self ].
	aMessage pragma method ifNil: [self error: '[Molecule] Error on contract changed notification.'. ^ self ].
	aMessage pragma method methodClass ifNil: [self error: '[Molecule] Error on contract changed notification.'. ^ self ].

	aComponentType := aMessage pragma method methodClass instanceSide.
	self contractChanged: aComponentType.
]

{ #category : #'dynamic contract update' }
MolComponentFactory >> deactivateDynamicContractUpdate [

	self isDynamicContractUpdateActivated ifFalse: [ ^ self ].
	self inform: '[Molecule] Dynamic Contract Update is not active'.
	self isDynamicContractUpdateActivated: false
]

{ #category : #'component definition' }
MolComponentFactory >> defineComponent: aComponent [
	"A component is a Class, define it"
	 | toUseTraits |
	aComponent isComponent ifFalse:[^self].
	
	self generateConsumedEventsComponentAccessorsFor: aComponent.
	self generateProducedEventsComponentAccessorsFor: aComponent.
	self generateUsedServicesComponentAccessorsFor: aComponent.
	self generateUsedParametersComponentAccessorsFor: aComponent.

	"Check if the object have a component type, the type should be deleted when work on a component class or not already added"
	aComponent haveComponentType ifFalse:[^self].
	
	"Check missing traits"
	toUseTraits := OrderedCollection withAll: aComponent consumedComponentEvents.
	toUseTraits addAll: aComponent providedComponentServices.
	toUseTraits addAll: aComponent providedComponentParameters.
	self checkUsedTrait: toUseTraits in: aComponent.
]

{ #category : #'component definition' }
MolComponentFactory >> defineComponentTypeImplementors: aComponentType [
	
	"Check if the object is a trait"
	aComponentType isTrait ifFalse:[self error: '[Molecule] Cannot define ComponentType implementors : This object is not a trait.'. ^self].
	aComponentType isComponentType ifFalse:[self error: '[Molecule] Cannot define a no ComponentType implementors trait.'. ^self]. 

	aComponentType users do: [ :user | self defineComponent: user ].
]

{ #category : #'dirty components' }
MolComponentFactory >> defineDirtyComponents [
	"Get all dirty Types and Components for defining them"
	
	dirtyComponentTypes do: [ :e | self defineComponentTypeImplementors: e ].
	dirtyComponentTypes := Set new.
	
	dirtyComponents do: [ :e | self defineComponent: e ].
	dirtyComponents := Set new.
]

{ #category : #'dirty components' }
MolComponentFactory >> dirtyComponentTypes [

	^dirtyComponentTypes 
]

{ #category : #'dirty components' }
MolComponentFactory >> dirtyComponents [

	^dirtyComponents
]

{ #category : #'private - code generation' }
MolComponentFactory >> generateComponentAccessorsFor: aSymbol withList: aCollection in: aComponent suffix: suffix [
	| selector sourceCode sourceMethod method |
	aCollection do: [ :trait | 
		selector := ('get' , trait printString , suffix) asSymbol.
		sourceCode := self
			              getSourceCodeFor: aSymbol
			              trait: trait
			              selector: selector.
		(aComponent allSelectors includes: selector) not
			ifTrue: [ 
				aComponent
					compile: sourceCode contents
					classified: aComponent protocolForComponentAccess ]
			ifFalse: [ "if the method exist inspect this source code for search any difference between the existing required services and the requested required services"
				"the selector must not be a parent"
				(aComponent selectors includes: selector) ifTrue: [ 
					method := aComponent >> selector.
					sourceMethod := method sourceCode.
					sourceMethod ifNotNil: [ 
						sourceMethod ~= sourceCode contents ifTrue: [ "rewrite the method"
							aComponent
								compile: sourceCode contents
								classified: aComponent protocolForComponentAccess ] ] ] ] ]
]

{ #category : #'code generation' }
MolComponentFactory >> generateConsumedEventsComponentAccessorsFor: aComponent [

	self removeOldConsumedEventsComponentAccessorsFor: aComponent.
	aComponent haveComponentType ifTrue:[
		self generateComponentAccessorsFor: #consumedEvents withList: aComponent consumedComponentEvents in: aComponent suffix: 'Subscriber'.
	].
]

{ #category : #'code generation' }
MolComponentFactory >> generateProducedEventsComponentAccessorsFor: aComponent [

	self removeOldProducedEventsComponentAccessorsFor: aComponent.
	aComponent haveComponentType ifTrue:[
		self generateComponentAccessorsFor: #producedEvents withList: aComponent producedComponentEvents in: aComponent suffix: 'Notifier'.
	].
]

{ #category : #'code generation' }
MolComponentFactory >> generateUsedParametersComponentAccessorsFor: aComponent [

	self removeOldUsedParametersAndServicesComponentAccessorsFor: aComponent.
	aComponent haveComponentType ifTrue:[
		self generateComponentAccessorsFor: #usedParameters withList: aComponent usedComponentParameters in: aComponent suffix: 'Provider'.
	].
]

{ #category : #'code generation' }
MolComponentFactory >> generateUsedServicesComponentAccessorsFor: aComponent [
 
	self removeOldUsedParametersAndServicesComponentAccessorsFor: aComponent.
	aComponent haveComponentType ifTrue:[
		self generateComponentAccessorsFor: #usedServices withList: aComponent usedComponentServices in: aComponent suffix: 'Provider'.
	].
]

{ #category : #'private - code generation' }
MolComponentFactory >> getConsumedEventSourceCodeFor: aTrait selector: selector [
	| writeStream |
	
	writeStream := WriteStream on: String new.
	writeStream nextPutAll: selector.
	writeStream crtab: 1.
	writeStream nextPutAll: '| eventsSymbol eventsSubscriber itf |'.
	writeStream crtab: 1.
	writeStream
		nextPutAll: 'itf := ';
		nextPutAll: aTrait asString;
		nextPutAll: '.'.
	writeStream crtab: 1.
	writeStream
		nextPutAll:
			'eventsSymbol := self eventsSubscribers at: itf ifAbsent: [self error:''Events not found''].'.
	writeStream crtab: 1.
	writeStream
		nextPutAll:
			'eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' named:  eventsSymbol ]. '.
	writeStream crtab: 1.
	writeStream nextPutAll: '^eventsSubscriber'.
	^ writeStream
]

{ #category : #'private - code generation' }
MolComponentFactory >> getProducedEventSourceCodeFor: aTrait selector: selector [
	| writeStream |
	
	writeStream := WriteStream on: String new.
	writeStream nextPutAll: selector.
	writeStream crtab: 1.
	writeStream
		nextPutAll: '^self eventsNotifiers at: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' ifAbsent: [nil]'.
	^ writeStream
]

{ #category : #'code generation' }
MolComponentFactory >> getSourceCodeFor: aSymbol trait: aTrait selector: aSelector [

	aSymbol = #producedEvents ifTrue:[^self getProducedEventSourceCodeFor: aTrait selector: aSelector ].
	aSymbol = #consumedEvents ifTrue:[^self getConsumedEventSourceCodeFor: aTrait selector: aSelector ].
	aSymbol = #usedServices ifTrue:[^self getUsedServicesSourceCodeFor: aTrait selector: aSelector ].
	aSymbol = #usedParameters ifTrue:[^self getUsedParametersSourceCodeFor: aTrait selector: aSelector ].
	self error: 'Component Type contract category not supported'.
]

{ #category : #'private - code generation' }
MolComponentFactory >> getUsedParametersSourceCodeFor: aTrait selector: selector [
	| writeStream |
	
	writeStream := WriteStream on: String new.
	writeStream nextPutAll: selector.
	writeStream crtab: 1.
	writeStream nextPutAll: '| parametersSymbol parametersProvider itf |'.
	writeStream crtab: 1.
	writeStream
		nextPutAll: 'itf := ';
		nextPutAll: aTrait asString;
		nextPutAll: '.'.
	writeStream crtab: 1.
	writeStream
		nextPutAll:
			'parametersSymbol := self parametersProviders at: itf ifAbsent: [self error:''parameters not found''].'.
	writeStream crtab: 1.
	writeStream
		nextPutAll:
			'parametersSymbol isSymbol
	 	ifTrue: 
			[parametersProvider := MolComponentManager default locatorServices 
						searchParametersProviderFor: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' named:  parametersSymbol]. '.
	writeStream crtab: 1.
	writeStream nextPutAll: '^parametersProvider'.
	^ writeStream
]

{ #category : #'private - code generation' }
MolComponentFactory >> getUsedServicesSourceCodeFor: aTrait selector: selector [
	| writeStream |
	
	writeStream := WriteStream on: String new.
	writeStream nextPutAll: selector.
	writeStream crtab: 1.
	writeStream nextPutAll: '| servicesSymbol servicesProvider itf |'.
	writeStream crtab: 1.
	writeStream
		nextPutAll: 'itf := ';
		nextPutAll: aTrait asString;
		nextPutAll: '.'.
	writeStream crtab: 1.
	writeStream
		nextPutAll:
			'servicesSymbol := self servicesProviders at: itf ifAbsent: [self error:''Services not found''].'.
	writeStream crtab: 1.
	writeStream
		nextPutAll:
			'servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' named:  servicesSymbol]. '.
	writeStream crtab: 1.
	writeStream nextPutAll: '^servicesProvider'.
	^ writeStream
]

{ #category : #'initalize-release' }
MolComponentFactory >> initialize [

	super initialize.

	dirtyComponentTypes := Set new.
	dirtyComponents := Set new.
	self initializeSystemAnnouncements.
	self initializeIcebergAnnouncements
]

{ #category : #'initalize-release' }
MolComponentFactory >> initializeIcebergAnnouncements [

	"activate (or desactivate) component contract update when iceberge is used (or not)"

	| announcer |
	announcer := SystemAnnouncer uniqueInstance weak.
	announcer ifNil: [ ^ self ].
	announcer
		when: MCVersionLoaderStarted
		send: #deactivateDynamicContractUpdate
		to: self.
	announcer
		when: MCVersionLoaderStopped
		send: #activateDynamicContractUpdate
		to: self
]

{ #category : #'initalize-release' }
MolComponentFactory >> initializeSystemAnnouncements [

	"Component Type Observer"
	pragmaCollector := (PragmaCollector new filter: [ :prg |  prg selector = #componentContract ]) reset.
	pragmaCollector announcer when: PragmaAnnouncement send: #contractChangedAnnouncement: to: self.
	
	"Component Implementation Observer"
	SystemAnnouncer uniqueInstance  when: ClassAdded send: #componentAddedAnnouncement: to: self.
	SystemAnnouncer uniqueInstance  when: ClassModifiedClassDefinition send: #componentChangedAnnouncement: to: self.
]

{ #category : #accessing }
MolComponentFactory >> isDynamicContractUpdateActivated [

	isDynamicContractUpdateActivated ifNil: [ isDynamicContractUpdateActivated := true ].
	^ isDynamicContractUpdateActivated
]

{ #category : #accessing }
MolComponentFactory >> isDynamicContractUpdateActivated: aBoolean [

	isDynamicContractUpdateActivated := aBoolean
]

{ #category : #'private - code generation' }
MolComponentFactory >> rebuildComponent: aComponent traitsAdding: aList [
	| classes |
	classes := aComponent allSuperclasses reverse.
	classes remove: Object; remove: ProtoObject.
	classes add: aComponent class.

	aList do: [:trait | | toBeAddedTrait |
		trait ifNotNil:[ 
			toBeAddedTrait := trait.
			"Cannot add the traits if already present"
			classes do: [ :c | 
				(c traitComposition includesTrait: trait) ifTrue:[toBeAddedTrait := nil].
			].
			toBeAddedTrait ifNotNil:[aComponent addToComposition: toBeAddedTrait].
		].
	].
]

{ #category : #'initalize-release' }
MolComponentFactory >> release [

	self releaseIcebergAnnouncements.
	self releaseSystemAnnouncements.
	isDynamicContractUpdateActivated := false.
	dirtyComponentTypes := nil.
	dirtyComponents := nil.

	super release
]

{ #category : #'initalize-release' }
MolComponentFactory >> releaseIcebergAnnouncements [

	| announcer |
	announcer := SystemAnnouncer uniqueInstance.
	announcer ifNil: [ ^ self ].
	announcer unsubscribe: self.
	announcer unsubscribe: self
]

{ #category : #'initalize-release' }
MolComponentFactory >> releaseSystemAnnouncements [

	pragmaCollector release.
	pragmaCollector := nil.

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #'code generation' }
MolComponentFactory >> removeOldConsumedEventsComponentAccessorsFor: aComponent [
 	"remove old consumed events but not the existing"
	| toBeRemoveConsumedSelectors |
	toBeRemoveConsumedSelectors := (aComponent selectors select:[ :s |  'get*Subscriber' match: (s asString)]) asOrderedCollection.
	
	"check if the selectors are already in the current consumed events, in case don't remove them"
	aComponent haveComponentType ifTrue:[
		aComponent consumedComponentEvents do:[ :e | 
			toBeRemoveConsumedSelectors copy do:[ :sel | ('get', e printString, 'Subscriber' = sel) ifTrue:[toBeRemoveConsumedSelectors remove: sel]].
		].
	].
	
	toBeRemoveConsumedSelectors do:[ :s | aComponent removeSelector: s].
]

{ #category : #'code generation' }
MolComponentFactory >> removeOldProducedEventsComponentAccessorsFor: aComponent [
 	"remove old produced events but not the existing"
	| toBeRemoveProducedSelectors |
	toBeRemoveProducedSelectors := (aComponent selectors select:[ :s |  'get*Notifier' match: (s asString)]) asOrderedCollection.
	
	"check if the selectors are already in the current produced events, in case don't remove them"
	aComponent haveComponentType ifTrue:[
		aComponent producedComponentEvents do:[ :e | 
			toBeRemoveProducedSelectors copy do:[ :sel | ('get', e printString, 'Notifier' = sel) ifTrue:[toBeRemoveProducedSelectors remove: sel]].
		].
	].
	
	toBeRemoveProducedSelectors do:[ :s | aComponent removeSelector: s].
]

{ #category : #'code generation' }
MolComponentFactory >> removeOldUsedParametersAndServicesComponentAccessorsFor: aComponent [
 	"remove old used parameters but not the existing or used services"
	| toBeRemoveProviderSelectors |
	toBeRemoveProviderSelectors := (aComponent selectors select:[ :s |  'get*Provider' match: (s asString)]) asOrderedCollection.
	
	"check if the selectors are already in the current used parameters or used services, in case don't remove them"
	aComponent haveComponentType ifTrue:[
		aComponent usedComponentParameters do:[ :e | 
			toBeRemoveProviderSelectors copy do:[ :sel | ('get', e printString, 'Provider' = sel) ifTrue:[toBeRemoveProviderSelectors remove: sel]].
		].
		aComponent usedComponentServices do:[ :e | 
			toBeRemoveProviderSelectors copy do:[ :sel | ('get', e printString, 'Provider' = sel) ifTrue:[toBeRemoveProviderSelectors remove: sel]].
		].
	].
	
	toBeRemoveProviderSelectors do:[ :s | aComponent removeSelector: s].
]
