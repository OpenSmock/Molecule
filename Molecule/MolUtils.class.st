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
MolUtils class >> allComponentInstancesOfType: aComponentType [

	| oc homeServices |
	(aComponentType notNil and:[aComponentType isTrait and:[aComponentType isComponentType]]) ifFalse:[^OrderedCollection new].
	
	oc := OrderedCollection new.
	homeServices := MolComponentManager default homeServices.
	aComponentType users do:[ :class | 
		(homeServices isDeployedComponent: class) ifTrue:[
			oc addAll: (homeServices deployedComponents at: class) values.
		]
	].
	
	^oc
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
	
	| componentType |
	anObject isTrait ifFalse: [ (self isComponentOrComponentClass: anObject) ifFalse: [ ^ {} ] ]. 
	componentType := (anObject isTrait and:[ anObject isComponentType]) ifTrue:[ anObject ] ifFalse: [ self componentType: anObject ].
	^ componentType ifNotNil: [ :e | ^ e consumedComponentEvents ] ifNil: [ ^ {} ]
]

{ #category : #'quick creation' }
MolUtils class >> createAllComponents [
	"instanciate and activate all deployed components"
	| homeServices components |
	
	homeServices := MolComponentManager default homeServices.
	components := homeServices deployedComponents.
	components keysDo: [ :aClass | homeServices instanciateComponent: aClass ].
	components keysDo: [ :aClass | homeServices activateComponent: aClass ]
]

{ #category : #'quick lifecycle' }
MolUtils class >> deployAndInitializeComponent: aComponentClass named: aName [
	"auto deploy, and instanciate quickly a component and return the instance"

	(MolComponentManager default deploymentServices isDeployedComponentImplementation: aComponentClass) ifFalse:[
		MolComponentManager default deploymentServices deployComponentImplementation: aComponentClass.
	].

	^ MolComponentManager default homeServices instanciateComponent: aComponentClass named: aName
]

{ #category : #'quick lifecycle' }
MolUtils class >> deployAndInitializeComponents: aComponentClassList [
	"deploy and instanciate quickly a list of components and return all instances"
	| components |

	components := OrderedCollection new.	
	aComponentClassList ifNil:[^components].
	aComponentClassList do:[ :componentClass | 		
		MolComponentManager default deploymentServices deployComponentImplementation: componentClass.
	].
	aComponentClassList do:[ :componentClass | 
		(MolComponentManager default homeServices instanciateComponent: componentClass) ifNotNil:[ :c | components add: c].
	].

	^components
]

{ #category : #accessing }
MolUtils class >> instanceKindOf: aClass [
	^self instanceKindOf: aClass named: #default
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
	^ self instanceOf: aClass named: #default
]

{ #category : #accessing }
MolUtils class >> instanceOf: aClass named: aName [
	^ MolComponentManager default homeServices instanceOf: aClass named: aName
]

{ #category : #testing }
MolUtils class >> isComponentOrComponentClass: anObject [

	anObject ifNil: [  ^ false ].
	anObject isClass ifTrue: [ ^ anObject isComponentClass ].
	^anObject isComponent
]

{ #category : #testing }
MolUtils class >> isInstanciateComponentOf: aClass [
	^ self isInstanciateComponentOf: aClass named: #default
]

{ #category : #testing }
MolUtils class >> isInstanciateComponentOf: aClass named: aName [
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
	
	| componentType |
	anObject isTrait ifFalse: [ (self isComponentOrComponentClass: anObject) ifFalse: [ ^ {} ] ]. 
	componentType := (anObject isTrait and:[ anObject isComponentType]) ifTrue:[ anObject ] ifFalse: [ self componentType: anObject ].
	^ componentType ifNotNil: [ :e | ^ e producedComponentEvents ] ifNil: [ ^ {} ]
]

{ #category : #'component contract' }
MolUtils class >> providedComponentParameters: anObject [
	"Get provided parameters of an object, return nil if no parameters was found"
	
	| componentType |
	anObject isTrait ifFalse: [ (self isComponentOrComponentClass: anObject) ifFalse: [ ^ {} ] ]. 
	componentType := (anObject isTrait and:[ anObject isComponentType]) ifTrue:[ anObject ] ifFalse: [ self componentType: anObject ].
	^ componentType ifNotNil: [ :e | ^ e providedComponentParameters ] ifNil: [ ^ {} ]
]

{ #category : #'component contract' }
MolUtils class >> providedComponentServices: anObject [
	"Get provided services of an object, return nil if no services was found"
	
	| componentType |
	anObject isTrait ifFalse: [ (self isComponentOrComponentClass: anObject) ifFalse: [ ^ {} ] ]. 
	componentType := (anObject isTrait and:[ anObject isComponentType]) ifTrue:[ anObject ] ifFalse: [ self componentType: anObject ].
	^ componentType ifNotNil: [ :e | ^ e providedComponentServices ] ifNil: [ ^ {} ]
]

{ #category : #'quick lifecycle' }
MolUtils class >> removeComponent: aComponentClass named: aName [
	"passivate quickly a component"

	MolComponentManager default homeServices removeComponent: aComponentClass named: aName.
]

{ #category : #'quick lifecycle' }
MolUtils class >> removeComponents: aComponentClassList [
	"pâssivate quickly a list of components"

	aComponentClassList ifNil:[^self].
	aComponentClassList do:[ :componentClass | 
		MolComponentManager default homeServices removeComponent: componentClass.
	].
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
	
	^ self startComponent: aComponentClass named: #default
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
	
	^ self stopComponent: aComponentClass named: #default
]

{ #category : #'quick start and stop' }
MolUtils class >> stopComponent: aComponentClass named: aName [
	"passivate and remove quickly a component"

	self removeComponent: aComponentClass named: aName.
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
	
	| componentType |
	anObject isTrait ifFalse: [ (self isComponentOrComponentClass: anObject) ifFalse: [ ^ {} ] ]. 
	componentType := (anObject isTrait and:[ anObject isComponentType]) ifTrue:[ anObject ] ifFalse: [ self componentType: anObject ].
	^ componentType ifNotNil: [ :e | ^ e usedComponentParameters ] ifNil: [ ^ {} ]
]

{ #category : #'component contract' }
MolUtils class >> usedComponentServices: anObject [
	"Get used services of an object, return nil if no services was found"
	
	| componentType |
	anObject isTrait ifFalse: [ (self isComponentOrComponentClass: anObject) ifFalse: [ ^ {} ] ]. 
	componentType := (anObject isTrait and:[ anObject isComponentType]) ifTrue:[ anObject ] ifFalse: [ self componentType: anObject ].
	^ componentType ifNotNil: [ :e | ^ e usedComponentServices ] ifNil: [ ^ {} ]
]
