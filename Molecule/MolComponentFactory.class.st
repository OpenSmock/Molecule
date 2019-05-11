"
I am used to generate component code.

When a component implementation and its trait type are defined, use method 'defineComponent' to generate automatically missing methods and traits.

Also, when the contract of ComponentType changes, 'defineComponent' is automatically send.
"
Class {
	#name : #MolComponentFactory,
	#superclass : #Object,
	#instVars : [
		'pragmaCollector'
	],
	#classVars : [
		'Default'
	],
	#category : #'Molecule-Core'
}

{ #category : #accessing }
MolComponentFactory class >> cleanUp [

	Default ifNil: [ ^self ].
	Default release.
	Default := nil. 
]

{ #category : #'componentImpl - creation' }
MolComponentFactory class >> createImplementationFor: aComponentType named: aSymbol in: aPackageName [

	(aComponentType traitComposition allTraits includes: MolComponentType)
		ifFalse: [ self error: 'Cannot create implementation for non MolComponentType object' ].
		
	self class environment
		at: aSymbol
		ifPresent: [ self error:'Do not redefine component implementation, please remove previous impl if necessary' ].
		
	OpalCompiler new evaluate:
			'MolAbstractComponentImpl subclass: ' , aSymbol printString
				,
					'
	uses: ' , aComponentType printString
				,
					'
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''' , aPackageName , ''''.
	
	(self class environment at: aSymbol) defineComponent
]

{ #category : #accessing }
MolComponentFactory class >> default [

	Default ifNil:[ Default := self new ].
	^Default
]

{ #category : #accessing }
MolComponentFactory class >> defineComponent: aComponentType [

	self default defineComponent: aComponentType
 

]

{ #category : #'class initialization' }
MolComponentFactory class >> initialize [ 
	self default.
]

{ #category : #'private - code checking' }
MolComponentFactory >> checkUsedTrait: aList in: aComponent [
	| eventAndServices bool missing |
	
	"check component used traits includes trait list "
	eventAndServices := self collectComponentConnectionTraits: aComponent.
	bool := false.
	missing := aList reject: [:e | eventAndServices includes: e].
	missing
		ifNotEmpty: [self rebuildComponent: aComponent traitsAdding: missing].
	eventAndServices := self collectComponentConnectionTraits: aComponent.
	bool
		ifFalse: [aList
				do: [:e | 
					(eventAndServices includes: e)
						ifFalse: [bool := UIManager default
								confirm:
									'Used trait is not declared (' , e printString
										, '), do you want to browse class ?']]].
	bool
		ifTrue: [aComponent browse]
]

{ #category : #toolbox }
MolComponentFactory >> collectComponentConnectionTraits: aComponent [

	^aComponent traitComposition allTraits select: [:e | (e traitComposition allTraits includes: MolComponentServices) or: [(e traitComposition allTraits includes: MolComponentEvents) or: [e traitComposition allTraits includes: MolComponentParameters]]].
]

{ #category : #changing }
MolComponentFactory >> contractChanged: aMessage [
	| modifiedComponent |
	modifiedComponent := aMessage pragma method methodClass instanceSide.
	self defineComponent: modifiedComponent
]

{ #category : #'component definition' }
MolComponentFactory >> defineComponent: aComponent [
	| toUseTraits traits |
	
	<todo:'PLA : use a better way to get composition traits'>
	traits := Set new.
	aComponent withAllSuperclassesDo: [ :c | 
		(c  ~= MolAbstractComponentImpl and:[c ~= Object and:[c ~= ProtoObject]]) ifTrue:[traits addAll: c traitComposition allTraits].
	].
	
	(traits includes: MolComponentType) 
		ifFalse:
			[self error: 'Define a component with no ComponentType trait.']. 
	
	(aComponent withAllSuperclasses anySatisfy: [ :class | class traits includes: MolComponentImpl ])
	ifTrue:
			[ self generateConsumedEventsComponentAccessorsFor: aComponent.
			self generateProducedEventsComponentAccessorsFor: aComponent.
			self generateUsedServicesComponentAccessorsFor: aComponent.
			self generateUsedParametersComponentAccessorsFor: aComponent.
				
			"check missing traits"
			toUseTraits := OrderedCollection withAll: aComponent consumedComponentEvents.
			toUseTraits addAll: aComponent providedComponentServices.
			toUseTraits addAll: aComponent providedComponentParameters.
			self checkUsedTrait: toUseTraits in: aComponent. 	]
			
		ifFalse:
			[aComponent isTrait
			ifTrue: [ aComponent users do: [ :user | self defineComponent: user ]] 
			ifFalse: [ self error: 'Unknown object defined.' ]]	
]

{ #category : #'private - code generation' }
MolComponentFactory >> generateComponentAccessorsFor: aSymbol withList: aCollection in: aComponent suffix: suffix [
	| selector sourceCode sourceMethod method selectors |
	
	aCollection
		do: [ :trait | 
			selector := ('get' , trait printString , suffix) asSymbol.
			sourceCode := self
				getSourceCodeFor: aSymbol
				trait: trait
				selector: selector.
			((selectors := aComponent allSelectors) includes: selector) not
				ifTrue: [ aComponent
						compile: sourceCode contents
						classified: aComponent protocolForComponentAccess ]
				ifFalse:
					[ "if the method exist inspect this source code for search any difference between the existing required services and the requested required services"
					method := aComponent >> selector.
					sourceMethod := method sourceCode.
					sourceMethod
						ifNotNil: [ sourceMethod ~= sourceCode contents
								ifTrue: [ "rewrite the method"
									aComponent
										compile: sourceCode contents
										classified: aComponent protocolForComponentAccess ] ] ] ]
]

{ #category : #'code generation' }
MolComponentFactory >> generateConsumedEventsComponentAccessorsFor: aComponent [
 
	^self generateComponentAccessorsFor: #consumedEvents withList: aComponent consumedComponentEvents in: aComponent suffix: 'Subscriber'
]

{ #category : #'code generation' }
MolComponentFactory >> generateProducedEventsComponentAccessorsFor: aComponent [
 
	^self generateComponentAccessorsFor: #producedEvents withList: aComponent producedComponentEvents in: aComponent suffix: 'Notifier'
		
		
]

{ #category : #'code generation' }
MolComponentFactory >> generateUsedParametersComponentAccessorsFor: aComponent [
 
	^self generateComponentAccessorsFor: #usedParameters withList: aComponent usedComponentParameters in: aComponent suffix: 'Provider'
		
]

{ #category : #'code generation' }
MolComponentFactory >> generateUsedServicesComponentAccessorsFor: aComponent [
 
	^self generateComponentAccessorsFor: #usedServices withList: aComponent usedComponentServices in: aComponent suffix: 'Provider'
		
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
	self error: 'type not supported'
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

	pragmaCollector := (PragmaCollector new filter: [:prg | prg keyword = #componentContract]) reset.
	pragmaCollector announcer when: PragmaAnnouncement send: #contractChanged: to: self 
]

{ #category : #'private - code generation' }
MolComponentFactory >> rebuildComponent: aComponent traitsAdding: aList [

	aList do: [:e | aComponent addToComposition: e].
]

{ #category : #'initalize-release' }
MolComponentFactory >> release [

	super release.
	
	pragmaCollector release.
	pragmaCollector := nil.
]
