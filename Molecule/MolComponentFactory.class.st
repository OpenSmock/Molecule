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

{ #category : #'component - contract management' }
MolComponentFactory class >> addConsumedEvents: aComponentEvents in: aComponentType [
	"Add a provided ComponentEvents in a ComponentType"
	| declaredConsumedComponentEvents selector sourceCode |
	
	(aComponentEvents isNil or:[aComponentEvents isTrait not]) ifTrue:[^self].
	aComponentEvents isComponentEvents ifFalse:[^self].
	(aComponentType isNil or:[aComponentType isTrait not]) ifTrue:[^self].
	aComponentType isComponentType ifFalse:[^self].
	
	"ComponentEvents already declare"
	(aComponentType isConsumeEvents: aComponentEvents) ifTrue:[^self].
	
	"Get declared events to rebuild the ComponentType accessor"
	declaredConsumedComponentEvents := aComponentType consumedComponentEvents asOrderedCollection.
	declaredConsumedComponentEvents add: aComponentEvents.
	
	selector := 'consumedComponentEvents'.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: selector.
	sourceCode crtab: 1.
	sourceCode
		nextPutAll: '<componentContract>';
		crtab: 1;
		"Empty : nextPutAll: '^ {}'."
		nextPutAll: '^ {'.
	1 to: (declaredConsumedComponentEvents size) do:[ :i |
		sourceCode nextPutAll: ' ' , (declaredConsumedComponentEvents at: i) printString , ' '.
		i < declaredConsumedComponentEvents size ifTrue:[sourceCode nextPutAll: '.'].
	].
	sourceCode nextPutAll: '}'.
	
	"Compile"
	aComponentType class
		compile: sourceCode contents 
		classified: self protocolForComponentEvents.
	
]

{ #category : #'component - contract management' }
MolComponentFactory class >> addProducedEvents: aComponentEvents in: aComponentType [
	"Add a provided ComponentEvents in a ComponentType"
	| declaredProducedComponentEvents selector sourceCode |

	(aComponentEvents isNil or:[aComponentEvents isTrait not]) ifTrue:[^self].
	aComponentEvents isComponentEvents ifFalse:[^self].
	(aComponentType isNil or:[aComponentType isTrait not]) ifTrue:[^self].
	aComponentType isComponentType ifFalse:[^self].
	
	"ComponentEvents already declare"
	(aComponentType isProduceEvents: aComponentEvents) ifTrue:[^self].
	
	"Get declared events to rebuild the ComponentType accessor"
	declaredProducedComponentEvents := aComponentType producedComponentEvents asOrderedCollection.
	declaredProducedComponentEvents add: aComponentEvents.
	
	selector := 'producedComponentEvents'.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: selector.
	sourceCode crtab: 1.
	sourceCode
		nextPutAll: '<componentContract>';
		crtab: 1;
		"Empty : nextPutAll: '^ {}'."
		nextPutAll: '^ {'.
	1 to: (declaredProducedComponentEvents size) do:[ :i |
		sourceCode nextPutAll: ' ' , (declaredProducedComponentEvents at: i) printString , ' '.
		i < declaredProducedComponentEvents size ifTrue:[sourceCode nextPutAll: '.'].
	].
	sourceCode nextPutAll: '}'.
	
	"Compile"
	aComponentType class
		compile: sourceCode contents 
		classified: self protocolForComponentEvents.
	
]

{ #category : #'component - contract management' }
MolComponentFactory class >> addProvidedParameters: aComponentParameters in: aComponentType [
	"Add a provided ComponentParameters in a ComponentType"
	| declaredProvidedComponentParameters selector sourceCode |

	(aComponentParameters isNil or:[aComponentParameters isTrait not]) ifTrue:[^self].
	aComponentParameters isComponentParameters ifFalse:[^self].
	(aComponentType isNil or:[aComponentType isTrait not]) ifTrue:[^self].
	aComponentType isComponentType ifFalse:[^self].
	
	"ComponentParameters already declare"
	(aComponentType isProvideParameters: aComponentParameters) ifTrue:[^self].
	
	"Get declared parameters to rebuild the ComponentType accessor"
	declaredProvidedComponentParameters := aComponentType providedComponentParameters asOrderedCollection.
	declaredProvidedComponentParameters add: aComponentParameters.
	
	selector := 'providedComponentParameters'.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: selector.
	sourceCode crtab: 1.
	sourceCode
		nextPutAll: '<componentContract>';
		crtab: 1;
		"Empty : nextPutAll: '^ {}'."
		nextPutAll: '^ {'.
	1 to: (declaredProvidedComponentParameters size) do:[ :i |
		sourceCode nextPutAll: ' ' , (declaredProvidedComponentParameters at: i) printString , ' '.
		i < declaredProvidedComponentParameters size ifTrue:[sourceCode nextPutAll: '.'].
	].
	sourceCode nextPutAll: '}'.
	
	"Compile"
	aComponentType class
		compile: sourceCode contents 
		classified: self protocolForComponentParameters.
	
]

{ #category : #'component - contract management' }
MolComponentFactory class >> addProvidedServices: aComponentServices in: aComponentType [
	"Add a provided ComponentServices in a ComponentType"
	| declaredProvidedComponentServices selector sourceCode |
	
	(aComponentServices isNil or:[aComponentServices isTrait not]) ifTrue:[^self].
	aComponentServices isComponentServices ifFalse:[^self].
	(aComponentType isNil or:[aComponentType isTrait not]) ifTrue:[^self].
	aComponentType isComponentType ifFalse:[^self].
	
	"ComponentServices already declare"
	(aComponentType isProvideServices: aComponentServices) ifTrue:[^self].
	
	"Get declared services to rebuild the ComponentType accessor"
	declaredProvidedComponentServices := aComponentType providedComponentServices asOrderedCollection.
	declaredProvidedComponentServices add: aComponentServices.
	
	selector := 'providedComponentServices'.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: selector.
	sourceCode crtab: 1.
	sourceCode
		nextPutAll: '<componentContract>';
		crtab: 1;
		"Empty : nextPutAll: '^ {}'."
		nextPutAll: '^ {'.
	1 to: (declaredProvidedComponentServices size) do:[ :i |
		sourceCode nextPutAll: ' ' , (declaredProvidedComponentServices at: i) printString , ' '.
		i < declaredProvidedComponentServices size ifTrue:[sourceCode nextPutAll: '.'].
	].
	sourceCode nextPutAll: '}'.
	
	"Compile"
	aComponentType class
		compile: sourceCode contents 
		classified: self protocolForComponentServices.
	
]

{ #category : #'component - contract management' }
MolComponentFactory class >> addUsedParameters: aComponentParameters in: aComponentType [
	"Add a provided ComponentParameters in a ComponentType"
	| declaredUsedComponentParameters selector sourceCode |
	
	(aComponentParameters isNil or:[aComponentParameters isTrait not]) ifTrue:[^self].
	aComponentParameters isComponentParameters ifFalse:[^self].
	(aComponentType isNil or:[aComponentType isTrait not]) ifTrue:[^self].
	aComponentType isComponentType ifFalse:[^self].
	
	"ComponentParameters already declare"
	(aComponentType isUseParameters: aComponentParameters) ifTrue:[^self].
	
	"Get declared parameters to rebuild the ComponentType accessor"
	declaredUsedComponentParameters := aComponentType usedComponentParameters asOrderedCollection.
	declaredUsedComponentParameters add: aComponentParameters.
	
	selector := 'usedComponentParameters'.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: selector.
	sourceCode crtab: 1.
	sourceCode
		nextPutAll: '<componentContract>';
		crtab: 1;
		"Empty : nextPutAll: '^ {}'."
		nextPutAll: '^ {'.
	1 to: (declaredUsedComponentParameters size) do:[ :i |
		sourceCode nextPutAll: ' ' , (declaredUsedComponentParameters at: i) printString , ' '.
		i < declaredUsedComponentParameters size ifTrue:[sourceCode nextPutAll: '.'].
	].
	sourceCode nextPutAll: '}'.
	
	"Compile"
	aComponentType class
		compile: sourceCode contents 
		classified: self protocolForComponentParameters.
	
]

{ #category : #'component - contract management' }
MolComponentFactory class >> addUsedServices: aComponentServices in: aComponentType [
	"Add a provided ComponentServices in a ComponentType"
	| declaredUsedComponentServices selector sourceCode |
	
	(aComponentServices isNil or:[aComponentServices isTrait not]) ifTrue:[^self].
	aComponentServices isComponentServices ifFalse:[^self].
	(aComponentType isNil or:[aComponentType isTrait not]) ifTrue:[^self].
	aComponentType isComponentType ifFalse:[^self].
	
	"ComponentServices already declare"
	(aComponentType isUseServices: aComponentServices) ifTrue:[^self].
	
	"Get declared services to rebuild the ComponentType accessor"
	declaredUsedComponentServices := aComponentType usedComponentServices asOrderedCollection.
	declaredUsedComponentServices add: aComponentServices.
	
	selector := 'usedComponentServices'.
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: selector.
	sourceCode crtab: 1.
	sourceCode
		nextPutAll: '<componentContract>';
		crtab: 1;
		"Empty : nextPutAll: '^ {}'."
		nextPutAll: '^ {'.
	1 to: (declaredUsedComponentServices size) do:[ :i |
		sourceCode nextPutAll: ' ' , (declaredUsedComponentServices at: i) printString , ' '.
		i < declaredUsedComponentServices size ifTrue:[sourceCode nextPutAll: '.'].
	].
	sourceCode nextPutAll: '}'.
	
	"Compile"
	aComponentType class
		compile: sourceCode contents 
		classified: self protocolForComponentServices.
	
]

{ #category : #accessing }
MolComponentFactory class >> cleanUp [

	<script: 'self cleanUp'>
	Default ifNil: [ ^ self ].
	Default release.
	Default := nil
]

{ #category : #'component - creation' }
MolComponentFactory class >> createComponentEvents: aSymbol in: aPackageName [
	"Create a ComponentEvents interface named aSymbol in a package"
	
	aSymbol ifNil:[^self].
	aPackageName ifNil:[^self].
	self class environment at: aSymbol ifPresent: [
		^ self error:'[Molecule] Do not create an existing ComponentEvents, remove it before.'.
	].

	OpalCompiler new evaluate:
			'Trait named: ' , aSymbol printString ,
	' 
	uses: MolComponentEvents
	package: ''' , aPackageName , ''''.
	
]

{ #category : #'component - creation' }
MolComponentFactory class >> createComponentForType: aComponentType named: aSymbol in: aPackageName [

	aComponentType ifNotNil: [ 
		(aComponentType isTrait and:[aComponentType isComponentType]) ifFalse:[ ^ NotAComponentTypeError signal: 'Cannot create Component for a no ComponentType object.' ].
	].
	aSymbol ifNil:[^ self error:'[Molecule] Cannot create a component without a name.'].
	aPackageName ifNil:[^ self error:'[Molecule] Cannot create a component without a package name.'].
		
	self class environment at: aSymbol ifPresent: [
		^ self error:'[Molecule] Do not redefine an existing Component, remove it before.' 
	].

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
]

{ #category : #'component - creation' }
MolComponentFactory class >> createComponentNamed: aSymbol in: aPackageName [

	aSymbol ifNil:[^self].
	aPackageName ifNil:[^self].
	self createComponentForType: nil named: aSymbol in: aPackageName
]

{ #category : #'component - creation' }
MolComponentFactory class >> createComponentParameters: aSymbol in: aPackageName [
	"Create a ComponentParameters interface named aSymbol in a package"
	
	aSymbol ifNil:[^self].
	aPackageName ifNil:[^self].
	self class environment at: aSymbol ifPresent: [
		^ self error:'[Molecule] Do not create an existing ComponentParameters, remove it before.'.
	].

	OpalCompiler new evaluate:
			'Trait named: ' , aSymbol printString ,
	' 
	uses: MolComponentParameters
	package: ''' , aPackageName , ''''.
	
]

{ #category : #'component - creation' }
MolComponentFactory class >> createComponentServices: aSymbol in: aPackageName [
	"Create a ComponentServices interface named aSymbol in a package"
	
	aSymbol ifNil:[^self].
	aPackageName ifNil:[^self].
	self class environment at: aSymbol ifPresent: [
		^ self error:'[Molecule] Do not create an existing ComponentServices, remove it before.'.
	].

	OpalCompiler new evaluate:
			'Trait named: ' , aSymbol printString ,
	' 
	uses: MolComponentServices
	package: ''' , aPackageName , ''''.
	
]

{ #category : #'component - creation' }
MolComponentFactory class >> createComponentType: aSymbol in: aPackageName [
	"Create a ComponentType named aSymbol in a package"
	
	aSymbol ifNil:[^self].
	aPackageName ifNil:[^self].
	self class environment at: aSymbol ifPresent: [
		^ self error:'[Molecule] Do not create an existing ComponentType, remove it before.'.
	].

	OpalCompiler new evaluate:
			'Trait named: ' , aSymbol printString ,
	' 
	uses: MolComponentType
	package: ''' , aPackageName , ''''.
	
]

{ #category : #accessing }
MolComponentFactory class >> default [

	<script: 'self default'>
	Default ifNil: [ Default := self new ].
	^ Default
]

{ #category : #accessing }
MolComponentFactory class >> defineAllComponents [
	"<script> Don't be a script : too much risk to perform without doing it on purpose"
	| componentClasses |
	componentClasses := Set new.
	MolAbstractComponentImpl allSubclassesDo:[ :component | componentClasses add: component ].
	MolComponentImpl users do: [:class | componentClasses add: class ].
	componentClasses do: [ :c | MolComponentFactory defineComponent: c ]
]

{ #category : #accessing }
MolComponentFactory class >> defineComponent: aComponentClass [

	self default defineComponent: aComponentClass
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

{ #category : #'class initialization' }
MolComponentFactory class >> isInitialized [
	"Test if the Component Factory is initialized"

	<script: 'self isInitialized inspect'>
	^ Default notNil
]

{ #category : #protocol }
MolComponentFactory class >> protocolForComponentAccess [

	^ 'component accessing'
]

{ #category : #protocol }
MolComponentFactory class >> protocolForComponentEvents [

	^ 'accessing - events'
]

{ #category : #protocol }
MolComponentFactory class >> protocolForComponentParameters [

	^ 'accessing - parameters'
]

{ #category : #protocol }
MolComponentFactory class >> protocolForComponentServices [

	^ 'accessing - services'
]

{ #category : #'dynamic contract update' }
MolComponentFactory >> activateDynamicContractUpdate [
	"Activate Dynamic Contract Update, this method display an information message to the user"
	
	self activateDynamicContractUpdate: true
]

{ #category : #'dynamic contract update' }
MolComponentFactory >> activateDynamicContractUpdate: isInform [
	"Activate Dynamic Contract Update, and choose to display an information message to the user"
	
	self isDynamicContractUpdateActivated ifTrue: [ ^ self ].
	MolUtils log: 'Dynamic Contract Update is active'.
	(isInform isNil or:[isInform]) ifTrue:[MolUtils showInformation: 'Dynamic Contract Update is active'].
	self isDynamicContractUpdateActivated: true
]

{ #category : #'private - code checking' }
MolComponentFactory >> checkAndRebuildUsedTraitList: aTraitList inComponentClass: aComponentClass [
	"Check if a Component Class uses a list of Trait Class and do uses"
	| traitList missingTraits |
	
	aTraitList isEmpty ifTrue:[ ^ self ].
	
	traitList := self collectComponentConnectionTraits: aComponentClass.
	missingTraits := aTraitList reject: [ :e | (traitList includes: e) and:[ e isObsolete ] ].
	missingTraits ifNotEmpty: [self rebuildComponent: aComponentClass traitsAdding: missingTraits].
]

{ #category : #'dirty components' }
MolComponentFactory >> collectComponentConnectionTraits: aComponentOrAComponentClass [
	"Collect a Component Traits : Services, Events and Parameters"
	| componentClass |
	aComponentOrAComponentClass ifNil:[^OrderedCollection new].
	componentClass := aComponentOrAComponentClass isClass ifTrue:[aComponentOrAComponentClass] ifFalse:[aComponentOrAComponentClass class].
	componentClass isComponentClass ifFalse:[^OrderedCollection new].
	
	^ componentClass traitComposition allTraits select: [ :e |
		e isComponentServices or:[e isComponentEvents or:[e isComponentParameters]]	
	]
]

{ #category : #announcements }
MolComponentFactory >> componentAddedAnnouncement: aClassAddedAnnouncement [

	| classOrTraitAdded |
	classOrTraitAdded := aClassAddedAnnouncement classAdded.
	self componentChanged: classOrTraitAdded
]

{ #category : #announcements }
MolComponentFactory >> componentChanged: aChangedClass [
	"Update a ComponentClass triggered by a class description change"
	
	(aChangedClass isTrait or:[aChangedClass isObsolete]) ifTrue:[^self].
	aChangedClass isComponentClass ifFalse:[^self].
	
	self isDynamicContractUpdateActivated ifTrue: [ 
		"We need to wait because of the changedClass should be removed and become obsolete"
		self flag:'PLA : This is a patch because of Molecule need not yet existing pharo system flags, warning : if a new fork is started on the same object there is a concurrency access risk, if necessary write some code to control a fork stack for each objects'.
		[(Delay forMilliseconds: 25) wait. aChangedClass isObsolete ifFalse:[self defineComponent: aChangedClass]] forkAt: Processor highIOPriority.
	] ifFalse: [ dirtyComponents add: aChangedClass].
]

{ #category : #announcements }
MolComponentFactory >> componentChangedAnnouncement: aClassModifiedClassDefinitionAnnouncement [

	aClassModifiedClassDefinitionAnnouncement ifNil: [ 
		^ self error: '[Molecule] Error on modified Component notification.'.
	].
	
	aClassModifiedClassDefinitionAnnouncement newClassDefinition ifNotNil: [ :c |
		c isObsolete ifFalse:[self componentChanged: c].
	].
]

{ #category : #announcements }
MolComponentFactory >> contractChanged: aComponentType [
	
	aComponentType ifNil: [ ^ self error: '[Molecule] Error on contract changed notification.' ].
	aComponentType isTrait ifFalse:[ "Only Component Type are supported" ^ self ].
	aComponentType isObsolete ifTrue:[^self].
	aComponentType = MolComponentType ifTrue:[ "Exception for the ComponentType Trait (Abstract ComponentType)" ^ self ].

	self isDynamicContractUpdateActivated ifTrue: [ 
		"need to fork the definition because new traits are not already injected here to the component"
		self flag:'PLA : This is a patch because of Molecule need not yet existing pharo system flags, warning : if a new fork is started on the same object there is a concurrency access risk, if necessary write some code to control a fork stack for each objects'.
		[(Delay forMilliseconds: 25) wait. aComponentType isObsolete ifFalse:[self defineComponentTypeImplementors: aComponentType]] forkAt: Processor highIOPriority.
	] ifFalse: [ dirtyComponentTypes add: aComponentType ]
]

{ #category : #announcements }
MolComponentFactory >> contractChangedAnnouncement: aPragmaAnnouncement [
	| aComponentType |
	
	(aPragmaAnnouncement isNil or:[aPragmaAnnouncement pragma isNil or:[aPragmaAnnouncement pragma method isNil or:[aPragmaAnnouncement pragma method methodClass isNil]]]) ifTrue:[
		^ self error: '[Molecule] Error on changed contract announcement.' 		
	].

	aComponentType := aPragmaAnnouncement pragma method methodClass instanceSide.
	self contractChanged: aComponentType.
]

{ #category : #'dynamic contract update' }
MolComponentFactory >> deactivateDynamicContractUpdate [
	"Deactivate Dynamic Contract Update, this method display an information message to the user"

	self deactivateDynamicContractUpdate: true.
]

{ #category : #'dynamic contract update' }
MolComponentFactory >> deactivateDynamicContractUpdate: isInform [ 
	"Deactivate Dynamic Contract Update, and choose to display an information message to the user"
	
	self isDynamicContractUpdateActivated ifFalse: [ ^ self ].
	MolUtils log: 'Dynamic Contract Update is not active'.
	(isInform isNil or:[isInform]) ifTrue:[MolUtils showInformation: 'Dynamic Contract Update is not active'].
	self isDynamicContractUpdateActivated: false
]

{ #category : #'component definition' }
MolComponentFactory >> defineComponent: aComponentClass [
	"A component is a Class, define it"
	 | toUseTraitList |
	(aComponentClass isNil or:[aComponentClass isClass not or:[aComponentClass isComponentClass not]]) ifTrue:[^self].
	
	"Generate or remove accessors"
	self generateOrRemoveConsumedEventsComponentAccessorsFor: aComponentClass.
	self generateOrRemoveProducedEventsComponentAccessorsFor: aComponentClass.
	self generateOrRemoveUsedServicesComponentAccessorsFor: aComponentClass.
	self generateOrRemoveUsedParametersComponentAccessorsFor: aComponentClass.

	"Check if the object have a component type, if not remove injected component contract traits"
	aComponentClass haveComponentType ifFalse:[ | traitList |
		"Remove persistant contract traits"
		traitList := self collectComponentConnectionTraits: aComponentClass.
		traitList do:[ :trait | aComponentClass removeFromComposition: trait ].
		^ self
	] ifTrue:[
		aComponentClass haveOwnComponentType ifTrue:[
			"Check missing traits"
			toUseTraitList := Set withAll: aComponentClass consumedComponentEvents.
			toUseTraitList addAll: aComponentClass providedComponentServices.
			toUseTraitList addAll: aComponentClass providedComponentParameters.
			self checkAndRebuildUsedTraitList: toUseTraitList inComponentClass: aComponentClass.
		].
	].
]

{ #category : #'component definition' }
MolComponentFactory >> defineComponentTypeImplementors: aComponentType [
	"Check if the object is a trait"

	| userList |
	aComponentType isTrait ifFalse: [ ^ self ].
	aComponentType isComponentType ifFalse: [ ^ self ].
	aComponentType isUsed ifFalse:[ ^ self ].
	
	"Get Component Type users ordered by class hiearchy size : class with more subclasses are at the top of the list"
	userList := aComponentType users copy asSortedCollection: [ :a :b | a subclasses size > b subclasses size ].
	
	userList do: [ :user | self defineComponent: user ].
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
	
	aCollection copy do: [ :trait |
		
		selector := ('get' , trait printString , suffix) asSymbol.
		sourceCode := self getSourceCodeFor: aSymbol trait: trait selector: selector.
		(aComponent allSelectors includes: selector) ifFalse: [ 
			aComponent compile: sourceCode contents classified: self class protocolForComponentAccess
		] ifTrue: [ 
			"if the method exist inspect this source code for search any difference between the existing required services and the requested required services"
			"the selector must not be a parent"
			(aComponent selectors includes: selector) ifTrue: [ 
				method := aComponent >> selector.
				sourceMethod := method sourceCode.
				sourceMethod ifNotNil: [ 
					sourceMethod ~= sourceCode contents ifTrue: [ 
					"rewrite the method"
						aComponent compile: sourceCode contents classified: self class protocolForComponentAccess 
					]. 
				]. 
			]. 
		]. 
	]
]

{ #category : #'code generation' }
MolComponentFactory >> generateOrRemoveConsumedEventsComponentAccessorsFor: aComponent [

	self removeOldConsumedEventsComponentAccessorsFor: aComponent.
	
	"Cannot generate if parent class have the same type"  
	(aComponent haveComponentType and:[aComponent haveOwnComponentType]) ifTrue:[
		self generateComponentAccessorsFor: #consumedEvents withList: aComponent consumedComponentEvents in: aComponent suffix: 'Subscriber'.
	].
]

{ #category : #'code generation' }
MolComponentFactory >> generateOrRemoveProducedEventsComponentAccessorsFor: aComponent [

	self removeOldProducedEventsComponentAccessorsFor: aComponent.
	
	(aComponent haveComponentType and:[aComponent haveOwnComponentType]) ifTrue:[
		self generateComponentAccessorsFor: #producedEvents withList: aComponent producedComponentEvents in: aComponent suffix: 'Notifier'.
	].
]

{ #category : #'code generation' }
MolComponentFactory >> generateOrRemoveUsedParametersComponentAccessorsFor: aComponent [

	self removeOldUsedParametersAndServicesComponentAccessorsFor: aComponent.
	
	(aComponent haveComponentType and:[aComponent haveOwnComponentType]) ifTrue:[
		self generateComponentAccessorsFor: #usedParameters withList: aComponent usedComponentParameters in: aComponent suffix: 'Provider'.
	].
]

{ #category : #'code generation' }
MolComponentFactory >> generateOrRemoveUsedServicesComponentAccessorsFor: aComponent [
 
	self removeOldUsedParametersAndServicesComponentAccessorsFor: aComponent.
	
	(aComponent haveComponentType and:[aComponent haveOwnComponentType]) ifTrue:[
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
		nextPutAll: 'eventsSymbol := self eventsSubscribers at: itf ';
		nextPutAll: 'ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].'.	
	writeStream crtab: 1.
	writeStream
		nextPutAll:
			'eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' named: eventsSymbol ]. '.
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
		nextPutAll: ' ifAbsent: [^MolNotFoundEventsNotifier new interface: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' name: nil].'.	
	^ writeStream
]

{ #category : #'code generation' }
MolComponentFactory >> getSourceCodeFor: aSymbol trait: aTrait selector: aSelector [

	aSymbol = #producedEvents ifTrue:[^self getProducedEventSourceCodeFor: aTrait selector: aSelector ].
	aSymbol = #consumedEvents ifTrue:[^self getConsumedEventSourceCodeFor: aTrait selector: aSelector ].
	aSymbol = #usedServices ifTrue:[^self getUsedServicesSourceCodeFor: aTrait selector: aSelector ].
	aSymbol = #usedParameters ifTrue:[^self getUsedParametersSourceCodeFor: aTrait selector: aSelector ].
	^ self error: 'Component Type contract category not supported'.
]

{ #category : #'private - code generation' }
MolComponentFactory >> getUsedParametersSourceCodeFor: aTrait selector: selector [
	| writeStream |
	
	writeStream := WriteStream on: String new.
	writeStream nextPutAll: selector.
	writeStream crtab: 1.
	writeStream nextPutAll: '| parametersSymbol parametersProvider itf |'.
	writeStream cr.
	writeStream crtab: 1.
	writeStream
		nextPutAll: 'itf := ';
		nextPutAll: aTrait asString;
		nextPutAll: '.'.
	writeStream crtab: 1.
	writeStream	nextPutAll: 'parametersSymbol := self parametersProviders at: itf ifAbsent: [nil].'.
	writeStream crtab: 1.	
	writeStream	nextPutAll: '(parametersSymbol isNil or:[parametersSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundParametersProvider new interface: itf name: nil ].'.
	writeStream cr.
	writeStream crtab: 1.
	writeStream
		nextPutAll: 'parametersProvider := MolComponentManager default locatorServices searchParametersProviderFor: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' named: parametersSymbol.'.
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
	writeStream cr.
	writeStream crtab: 1.
	writeStream
		nextPutAll: 'itf := ';
		nextPutAll: aTrait asString;
		nextPutAll: '.'.
	writeStream crtab: 1.
	writeStream	nextPutAll: 'servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].'.
	writeStream crtab: 1.	
	writeStream	nextPutAll: '(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].'.
	writeStream cr.
	writeStream crtab: 1.
	writeStream
		nextPutAll: 'servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: ';
		nextPutAll: aTrait asString;
		nextPutAll: ' named: servicesSymbol.'.
	writeStream crtab: 1.
	writeStream nextPutAll: '^servicesProvider'.
	^ writeStream
]

{ #category : #'initialize - release' }
MolComponentFactory >> initialize [

	super initialize.

	dirtyComponentTypes := Set new.
	dirtyComponents := Set new.
	self initializePragmaAnnouncements.
	self initializeSystemAnnouncements
]

{ #category : #'initialize - release' }
MolComponentFactory >> initializePragmaAnnouncements [
	"Component Type Observer"
	pragmaCollector := (PragmaCollector new filter: [ :prg |  prg selector = #componentContract ]) reset.
	pragmaCollector announcer when: PragmaAnnouncement send: #contractChangedAnnouncement: to: self.
]

{ #category : #'initialize - release' }
MolComponentFactory >> initializeSystemAnnouncements [
	"Activate (or desactivate) component contract update when iceberge is used (or not)"
	| announcer |
	announcer := SystemAnnouncer uniqueInstance weak.
	announcer ifNil: [
		MolUtils log: 'Error on Systems announcements initialization, system Announcer is nil'.
		^ self 
	].

	"Component Implementation Observer"
	announcer when: ClassAdded send: #componentAddedAnnouncement: to: self.
	announcer when: ClassModifiedClassDefinition send: #componentChangedAnnouncement: to: self.

	"Monticello events"
	announcer when: #MCVersionLoaderStarted send: #deactivateDynamicContractUpdate: to: self with: false.
	announcer when: #MCVersionLoaderStopped send: #activateDynamicContractUpdate: to: self with: false.
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
MolComponentFactory >> rebuildComponent: aComponentClass traitsAdding: aTraitsList [
	| classes |
	"Get class hierarchy of the component class and clean classes not concerned by Component Contract Traits"
	classes := aComponentClass allSuperclasses reverse.
	classes remove: Object; remove: ProtoObject; remove: MolAbstractComponentImpl ifAbsent:[nil].
	classes add: aComponentClass.

	aTraitsList do: [:trait | | toBeAddedTrait |
		(trait notNil and:[trait isTrait and:[trait isObsolete not]]) ifTrue:[ 
			toBeAddedTrait := trait.
			"Cannot add the traits if already present in superclasses"
			classes do: [ :c | toBeAddedTrait ifNotNil:[ (c allTraits includes: trait) ifTrue:[toBeAddedTrait := nil] ]].
			toBeAddedTrait ifNotNil:[
				aComponentClass traitComposition isEmpty 
					ifTrue:[aComponentClass setTraitComposition: toBeAddedTrait] 
					ifFalse:[	aComponentClass addToComposition: toBeAddedTrait].
			].
		].
	].
]

{ #category : #'initialize - release' }
MolComponentFactory >> release [

	self releaseSystemAnnouncements.
	self releasePragmaAnnouncements.
	isDynamicContractUpdateActivated := false.
	dirtyComponentTypes := nil.
	dirtyComponents := nil.

	super release
]

{ #category : #'initialize - release' }
MolComponentFactory >> releasePragmaAnnouncements [

	pragmaCollector release.
	pragmaCollector := nil
]

{ #category : #'initialize - release' }
MolComponentFactory >> releaseSystemAnnouncements [

	| announcer |
	announcer := SystemAnnouncer uniqueInstance.
	announcer ifNil: [ ^ self ].
	announcer unsubscribe: self
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
