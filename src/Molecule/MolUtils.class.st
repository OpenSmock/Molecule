"
I am a toolbox which provide some additional services.

I have in particular a log system that you can activate or disactivate, and use for your own components.
"
Class {
	#name : #MolUtils,
	#superclass : #Object,
	#classVars : [
		'isLogActive'
	],
	#category : #'Molecule-Tools'
}

{ #category : #'quick lifecycle' }
MolUtils class >> activateComponent: aComponentClass named: aName [
	"activate quickly a component"

	MolComponentManager default homeServices activateComponent: aComponentClass named: aName.

]

{ #category : #'quick lifecycle' }
MolUtils class >> activateComponents: aComponentClassList [
	"activate quickly a list of components"

	aComponentClassList ifNil:[^self].
	aComponentClassList do:[ :componentClass | 
		MolComponentManager default homeServices activateComponent: componentClass.
	].
]

{ #category : #accessing }
MolUtils class >> allComponentImplementationClassesOfType: aComponentType [
	"Return a list of component Class which are implemented a component Type"
	
	| list |
	list := Set new.	
	aComponentType users do:[ :class |
		"class should be another trait or a component impl class"
		class isTrait 
			ifFalse:[ 
				list add: class. 
				list addAll: (class allSubclasses) ] 
			ifTrue:[ list addAll: (self allComponentImplementationClassesOfType: class) ].
	].

	^ list asOrderedCollection
]

{ #category : #accessing }
MolUtils class >> allComponentInstancesOfType: aComponentType [

	| oc homeServices classes |
	(aComponentType notNil and:[aComponentType isTrait and:[aComponentType isComponentType]]) ifFalse:[^OrderedCollection new].
	
	oc := OrderedCollection new.
	homeServices := MolComponentManager default homeServices.
	
	classes := self allComponentImplementationClassesOfType: aComponentType.
	classes do:[ :c |
		(homeServices isDeployedComponent: c) ifTrue:[				
			oc addAll: (homeServices deployedComponents at: c) values.
		]
	].
	
	^ oc
]

{ #category : #private }
MolUtils class >> allComponentTypes [
	"Return all ComponentTypes traits"

	^ self environment allTraits select: [ :t | t isComponentType ]
]

{ #category : #'component contract' }
MolUtils class >> componentType: aComponentOrComponentClass [
	"Get component type of a component or a component class, return nil if no type was found"
	
	(self isComponentOrComponentClass: aComponentOrComponentClass) ifFalse: [ ^ nil ].
	^aComponentOrComponentClass isClass 
		ifTrue: [ aComponentOrComponentClass componentType ]
		ifFalse: [ aComponentOrComponentClass class componentType ]
]

{ #category : #'component contract' }
MolUtils class >> consumedComponentEvents: anObject [
	"Get consumed events of an object, return nil if no events was found"

	| componentType set |
	anObject isTrait ifFalse: [
		(self isComponentOrComponentClass: anObject) ifFalse: [ ^ {  } ] ].
	componentType := (anObject isTrait and: [ anObject isComponentType ])
		                 ifTrue: [ anObject ]
		                 ifFalse: [ self componentType: anObject ].
	^ componentType
		  ifNotNil: [ :e |
			  set := Set new.
			set addAll: e consumedComponentEvents.
			  (anObject class respondsTo: #consumedComponentEvents)
				  ifTrue: [ set addAll: anObject class consumedComponentEvents ]
				  ifFalse: [ set addAll: anObject consumedComponentEvents ].
			  ^ set asArray ]
		  ifNil: [ ^ {  } ]
]

{ #category : #'quick creation' }
MolUtils class >> createAllComponents [
	"instantiate and activate all deployed components"

	| homeServices components |
	homeServices := MolComponentManager default homeServices.
	components := homeServices deployedComponents.
	components keysDo: [ :aClass | homeServices instantiateComponent: aClass ].
	components keysDo: [ :aClass | homeServices activateComponent: aClass ]
]

{ #category : #name }
MolUtils class >> defaultComponentName [
	"Used when a component instanciation is not nammed"

	^ #default
]

{ #category : #'quick lifecycle' }
MolUtils class >> deployAndInitializeComponent: aComponentClass named: aName [
	"auto deploy, and instantiate quickly a component and return the instance"

	(MolComponentManager default deploymentServices isDeployedComponentImplementation: aComponentClass) ifFalse: [
		MolComponentManager default deploymentServices deployComponentImplementation: aComponentClass 
	].

	^ MolComponentManager default homeServices instantiateComponent: aComponentClass named: aName
]

{ #category : #'quick lifecycle' }
MolUtils class >> deployAndInitializeComponents: aComponentClassList [
	"deploy and instantiate quickly a list of components and return all instances"

	| components |
	components := OrderedCollection new.
	aComponentClassList ifNil: [ ^ components ].
	aComponentClassList do: [ :componentClass |
		MolComponentManager default deploymentServices deployComponentImplementation: componentClass 
	].
	aComponentClassList do: [ :componentClass |
		(MolComponentManager default homeServices instantiateComponent: componentClass) ifNotNil: [ :c | components add: c ] 
	].

	^ components
]

{ #category : #private }
MolUtils class >> doRandomComponentNameForType: aComponentType [

	^ (aComponentType printString, (Random new next * 10000000) rounded printString) asSymbol
	
]

{ #category : #name }
MolUtils class >> generateComponentNameForType: aComponentType [

	| instances componentName usedNames found |
	aComponentType ifNil: [ ^ nil ].
	componentName := self doRandomComponentNameForType: aComponentType.
	found := false.

	"check if the name is not used"
	[ found ] whileFalse: [
		instances := self allComponentInstancesOfType: aComponentType.
		usedNames := instances collect: [ :c | c componentName ].
		componentName := self doRandomComponentNameForType: aComponentType.
		found := usedNames isEmpty
			         ifTrue: [ true ]
			         ifFalse: [ (usedNames includes: componentName) not ] ].

	^ componentName
]

{ #category : #accessing }
MolUtils class >> instanceKindOf: aClass [

	^ self instanceKindOf: aClass named: self defaultComponentName
]

{ #category : #accessing }
MolUtils class >> instanceKindOf: aClass named: aName [
	| instance |
	
	(self instanceOf: aClass named: aName) ifNil:[
		aClass allSubclasses do: 
			[:c |
			instance := self instanceOf: c named: aName.
			instance ifNotNil: [^instance]]].
]

{ #category : #accessing }
MolUtils class >> instanceOf: aClass [

	^ self instanceOf: aClass named: self defaultComponentName
]

{ #category : #accessing }
MolUtils class >> instanceOf: aClass named: aName [
	^ MolComponentManager default homeServices instanceOf: aClass named: aName
]

{ #category : #testing }
MolUtils class >> isComponentObject: anObject [
	"Return if an object is related to Component object (Component, ComponentType, Services, etc.), not considering technical classes as a positive result (MolComponentType, MolComponentImplementation, MolComponentServices, etc.)"

	(self isComponentOrComponentClass: anObject) ifTrue: [ ^ true ].
	anObject isTrait ifTrue:[
		anObject isComponentType ifTrue:[ ^ true ].
		anObject isComponentServices ifTrue:[ ^ true ].
		anObject isComponentEvents ifTrue:[ ^ true ].
		anObject isComponentParameters ifTrue:[ ^ true ].
	].
	^ false
]

{ #category : #testing }
MolUtils class >> isComponentOrComponentClass: anObject [

	anObject ifNil: [  ^ false ].
	anObject isClass ifTrue: [ ^ anObject isComponentClass ].
	^anObject isComponent
]

{ #category : #testing }
MolUtils class >> isInstanciateComponentOf: aClass [

	self deprecated: 'Use isInstantiateComponentOf:'
		transformWith: '`@receiver isInstanciateComponentOf: `@aClass' -> '`@receiver isInstantiateComponentOf: `@aClass'.
	^ self isInstantiateComponentOf: aClass
]

{ #category : #testing }
MolUtils class >> isInstanciateComponentOf: aClass named: aName [

	self deprecated: 'Use isInstantiateComponentOf: named: '
		transformWith: '`@receiver isInstanciateComponentOf: `@aClass named: `@aName' -> '`@receiver isInstantiateComponentOf: `@aClass named: `@aName'.
	^ self isInstantiateComponentOf: aClass named: aName
]

{ #category : #testing }
MolUtils class >> isInstantiateComponentOf: aClass [

	^ self isInstantiateComponentOf: aClass named: self defaultComponentName
]

{ #category : #testing }
MolUtils class >> isInstantiateComponentOf: aClass named: aName [

	^ (MolComponentManager default homeServices instanceOf: aClass named: aName) notNil
]

{ #category : #accessing }
MolUtils class >> isLogActive [

	isLogActive ifNil: [ isLogActive := false ].
	^ isLogActive
]

{ #category : #accessing }
MolUtils class >> isLogActive: aBoolean [

	isLogActive := aBoolean
]

{ #category : #log }
MolUtils class >> log: aString [
	"Log a message"

	| string |
	self isLogActive ifFalse: [ ^ self ].
	string := aString ifNil: [ 'Unkown information to log.' ].
	self traceCr: '[Molecule] ' , string
]

{ #category : #'component contract' }
MolUtils class >> offeredTypes: aComponentContractInterface [
	"Get types that are part of a component contract offered as Services, Events, or Parameters interface"

	| list |
	list := Set new.
	aComponentContractInterface ifNil:[ ^ list asOrderedCollection ].
	aComponentContractInterface isTrait ifFalse:[ ^ list asOrderedCollection ].
	(aComponentContractInterface isComponentServices not and:[aComponentContractInterface isComponentEvents not and:[aComponentContractInterface isComponentParameters not]]) ifTrue:[ ^ list asOrderedCollection ].
	
	"Collect all required"
	self allComponentTypes do:[ :type | 
		aComponentContractInterface isComponentServices ifTrue:[ 
			(type isProvideServices: aComponentContractInterface) ifTrue:[ list add: type ].
		] ifFalse:[
			aComponentContractInterface isComponentEvents ifTrue:[ 
				(type isProduceEvents: aComponentContractInterface) ifTrue:[ list add: type ].
			] ifFalse:[
				(type isProvideParameters: aComponentContractInterface) ifTrue:[ list add: type ].
			].
		].
	].

	^ list asOrderedCollection  
]

{ #category : #'quick lifecycle' }
MolUtils class >> passivateComponent: aComponentClass named: aName [
	"passivate quickly a component"

	MolComponentManager default homeServices passivateComponent: aComponentClass named: aName.
]

{ #category : #'quick lifecycle' }
MolUtils class >> passivateComponents: aComponentClassList [
	"pâssivate quickly a list of components"

	aComponentClassList ifNil:[^self].
	aComponentClassList do:[ :componentClass | 
		MolComponentManager default homeServices passivateComponent: componentClass.
	].
]

{ #category : #'component contract' }
MolUtils class >> producedComponentEvents: anObject [
	"Get produced events of an object, return nil if no events was found"

	| componentType set |
	anObject isTrait ifFalse: [
		(self isComponentOrComponentClass: anObject) ifFalse: [ ^ {  } ] ].
	componentType := (anObject isTrait and: [ anObject isComponentType ])
		                 ifTrue: [ anObject ]
		                 ifFalse: [ self componentType: anObject ].
	^ componentType
		  ifNotNil: [ :e |
			  set := Set new.
			set addAll: e producedComponentEvents.
			  (anObject class respondsTo: #producedComponentEvents)
				  ifTrue: [ set addAll: anObject class producedComponentEvents ]
				  ifFalse: [ set addAll: anObject producedComponentEvents ].
			  
			  ^ set asArray ]
		  ifNil: [ ^ {  } ]
]

{ #category : #'component contract' }
MolUtils class >> providedComponentParameters: anObject [
	"Get provided parameters of an object, return nil if no parameters was found"

	| componentType set |
	anObject isTrait ifFalse: [
		(self isComponentOrComponentClass: anObject) ifFalse: [ ^ {  } ] ].
	componentType := (anObject isTrait and: [ anObject isComponentType ])
		                 ifTrue: [ anObject ]
		                 ifFalse: [ self componentType: anObject ].
	^ componentType
		  ifNotNil: [ :e |
			  set := Set new.
			set addAll: e providedComponentParameters.
			  (anObject class respondsTo: #providedComponentParameters)
				  ifTrue: [
				  set addAll: anObject class providedComponentParameters ]
				  ifFalse: [ set addAll: anObject providedComponentParameters ].
			  
			  ^ set asArray ]
		  ifNil: [ ^ {  } ]
]

{ #category : #'component contract' }
MolUtils class >> providedComponentServices: anObject [
	"Get provided services of an object, return nil if no services was found"
	| componentType list isType |
	(self isComponentObject: anObject) ifFalse: [ ^ OrderedCollection new ].

	list := Set new.
	isType := anObject isTrait and: [ anObject isComponentType ].
	componentType := isType
		                 ifTrue: [ anObject ]
		                 ifFalse: [ self componentType: anObject ].

	"add component type services"
	componentType ifNotNil: [ :e |
		list addAll: e providedComponentServices ].

	"add component implementation overridden services"
	isType ifFalse: [
		"sometimes, when an overridden contract is removed, the componentype trait is not yet applied, need to check if the object respondsTo:"
		(anObject class respondsTo: #providedComponentServices) ifTrue: [ list addAll: anObject class providedComponentServices ].
		(anObject respondsTo: #providedComponentServices) ifTrue: [ list addAll: anObject providedComponentServices ] 
	].

	^ list asOrderedCollection
]

{ #category : #'quick lifecycle' }
MolUtils class >> removeComponent: aComponentClass named: aName [
	"passivate quickly a component"

	MolComponentManager default homeServices removeComponent: aComponentClass named: aName.
]

{ #category : #'quick lifecycle' }
MolUtils class >> removeComponent: aComponentClass named: aName ifAbsent: aBlock [
	"passivate quickly a component"

	^MolComponentManager default homeServices
		removeComponent: aComponentClass
		named: aName
		ifAbsent: aBlock
]

{ #category : #'quick lifecycle' }
MolUtils class >> removeComponents: aComponentClassList [
	"pâssivate quickly a list of components"

	aComponentClassList ifNil:[^self].
	aComponentClassList do:[ :componentClass | 
		MolComponentManager default homeServices removeComponent: componentClass.
	].
]

{ #category : #'component contract' }
MolUtils class >> requiredTypes: aComponentContractInterface [
	"Get types that are part of a component contract required as Services, Events, or Parameters interface"

	| list |
	list := Set new.
	aComponentContractInterface ifNil:[ ^ list asOrderedCollection ].
	aComponentContractInterface isTrait ifFalse:[ ^ list asOrderedCollection ].
	(aComponentContractInterface isComponentServices not and:[aComponentContractInterface isComponentEvents not and:[aComponentContractInterface isComponentParameters not]]) ifTrue:[ ^ list asOrderedCollection ].
	
	"Collect all required"
	self allComponentTypes do:[ :type | 
		aComponentContractInterface isComponentServices ifTrue:[ 
			(type isUseServices: aComponentContractInterface) ifTrue:[ list add: type ].
		] ifFalse:[
			aComponentContractInterface isComponentEvents ifTrue:[ 
				(type isConsumeEvents: aComponentContractInterface) ifTrue:[ list add: type ].
			] ifFalse:[
				(type isUseParameters: aComponentContractInterface) ifTrue:[ list add: type ].
			].
		].
	].

	^ list asOrderedCollection  
]

{ #category : #log }
MolUtils class >> showInformation: aString [
	"Inform the user with a message into the Pharo UI"

	| string |
	string := aString ifNil: [ 'Unkown information to display.' ].
	string isString ifFalse:[string := string printString ].
	self inform: '[Molecule] ' , string
]

{ #category : #'quick start and stop' }
MolUtils class >> startComponent: aComponentClass [
	"deploy, initialize and activate quickly a component and return the instance"
	
	^ self startComponent: aComponentClass named: self defaultComponentName
]

{ #category : #'quick start and stop' }
MolUtils class >> startComponent: aComponentClass named: aName [
	"auto deploy, initialize and activate quickly a component and return the instance"
	| component |

	component := self deployAndInitializeComponent: aComponentClass named: aName.
	self activateComponent: aComponentClass named: aName.
	
	^ component
]

{ #category : #'quick start and stop' }
MolUtils class >> startComponents: aComponentClassList [
	"deploy, initialize and activate quickly a list of components and return all instances"
	| startedComponents |

	startedComponents := self deployAndInitializeComponents: aComponentClassList.	
	self activateComponents: aComponentClassList.

	^startedComponents
]

{ #category : #'quick start and stop' }
MolUtils class >> stopComponent: aComponentClass [
	"passivate, remove and undeploy quickly a component"
	
	^ self stopComponent: aComponentClass named: self defaultComponentName
]

{ #category : #'quick start and stop' }
MolUtils class >> stopComponent: aComponentClass named: aName [
	"passivate and remove quickly a component"

	^self removeComponent: aComponentClass named: aName
]

{ #category : #'quick start and stop' }
MolUtils class >> stopComponent: aComponentClass named: aName ifAbsent: aBlock [
	"passivate and remove quickly a component"

	^self removeComponent: aComponentClass named: aName ifAbsent: aBlock
]

{ #category : #'quick start and stop' }
MolUtils class >> stopComponents: aComponentClassList [
	"remove quickly a list of components"

	self removeComponents: aComponentClassList
]

{ #category : #actions }
MolUtils class >> toggleLog [
	"Active (or deactive) Molecule logs"

	self isLogActive: self isLogActive not.
	self isLogActive
		ifTrue: [ MolUtils showInformation: 'Logs are active' ]
		ifFalse: [ MolUtils showInformation: 'Logs are not active' ]
]

{ #category : #'component contract' }
MolUtils class >> usedComponentParameters: anObject [
	"Get used parameters of an object, return nil if no parameters was found"

	| componentType set |
	anObject isTrait ifFalse: [
		(self isComponentOrComponentClass: anObject) ifFalse: [ ^ {  } ] ].
	componentType := (anObject isTrait and: [ anObject isComponentType ])
		                 ifTrue: [ anObject ]
		                 ifFalse: [ self componentType: anObject ].
	^ componentType
		  ifNotNil: [ :e |
			  set := Set new.
			  set addAll: e usedComponentParameters.
			  (anObject class respondsTo: #usedComponentParameters)
				  ifTrue: [ set addAll: anObject class usedComponentParameters ]
				  ifFalse: [ set addAll: anObject usedComponentParameters ].
			  ^ set asArray ]
		  ifNil: [ ^ {  } ]
]

{ #category : #'component contract' }
MolUtils class >> usedComponentServices: anObject [
	"Get used services of an object, return nil if no services was found. Considere also overidden contract in a Component implementation."

	| componentType list isType |
	(self isComponentObject: anObject) ifFalse: [ ^ OrderedCollection new ].

	list := Set new.
	isType := anObject isTrait and: [ anObject isComponentType ].
	componentType := isType
		                 ifTrue: [ anObject ]
		                 ifFalse: [ self componentType: anObject ].

	"add component type services"
	componentType ifNotNil: [ :e |
		list addAll: e usedComponentServices ].

	"add component implementation overridden services"
	isType ifFalse: [
		"sometimes, when an overridden contract is removed, the componentype trait is not yet applied, need to check if the object respondsTo:"
		(anObject class respondsTo: #usedComponentServices) ifTrue: [ list addAll: anObject class usedComponentServices ].
		(anObject respondsTo: #usedComponentServices) ifTrue: [ list addAll: anObject usedComponentServices ] 
	].

	^ list asOrderedCollection
]
