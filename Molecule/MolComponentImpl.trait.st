"
I am the trait which define a component implementation. Use me to create a component implementation, but do not forget to implement the behavior of methods componentName, componentName:, componentConnector and componentConnector:.

Otherwise, you can use AbstractComponentImpl as superclass to define component implementation.

Also,  a component needs a definition. See ComponentType for more informations.

Naming conventions for all my  users :
<component type name>[something relative to my specific implementation]ComponentImpl.
If the component has only one implementation, it is not necessary to precise something about the specific implementation.

"
Trait {
	#name : #MolComponentImpl,
	#instVars : [
		'componentConnector',
		'componentName'
	],
	#category : #'Molecule-Core-Impl'
}

{ #category : #'life cycle' }
MolComponentImpl classSide >> activate [
	^MolComponentManager default homeServices activateComponent: self.
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> activate: aComponentName [
	^MolComponentManager default homeServices activateComponent: self named: aComponentName.
]

{ #category : #testing }
MolComponentImpl classSide >> componentType [
	| traits |

	traits := Set new.
	self withAllSuperclassesDo: [ :c | 
		(c  ~= MolAbstractComponentImpl and:[c ~= Object and:[c ~= ProtoObject]]) ifTrue:[traits addAll: c traitComposition allTraits].
	].
	^(traits detect:[ :t | t traitComposition includesTrait: MolComponentType ] ifNone:[nil])
]

{ #category : #'component definition' }
MolComponentImpl classSide >> defineComponent [

	self removeProtocol: MolComponentFactory protocolForComponentAccess.
	MolComponentFactory defineComponent: self.

]

{ #category : #deployment }
MolComponentImpl classSide >> deploy [
	^MolComponentManager default deploymentServices deployComponentImplementation: self.
]

{ #category : #testing }
MolComponentImpl classSide >> haveComponentType [
	| traits |

	traits := Set new.
	self withAllSuperclassesDo: [ :c | 
		(c  ~= MolAbstractComponentImpl and:[c ~= Object and:[c ~= ProtoObject]]) ifTrue:[traits addAll: c traitComposition allTraits].
	].
	^(traits includes: MolComponentType)
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> instanciate [
	^MolComponentManager default homeServices instanciateComponent: self.
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> instanciate: aComponentName [
	^MolComponentManager default homeServices instanciateComponent: self named: aComponentName.
]

{ #category : #testing }
MolComponentImpl classSide >> isComponentClass [
	^ true
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> passivate [
	^MolComponentManager default homeServices passivateComponent: self.
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> passivate: aComponentName [
	^MolComponentManager default homeServices passivateComponent: self named: aComponentName.
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> remove [
	^MolComponentManager default homeServices removeComponent: self.
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> remove: aComponentName [
	^MolComponentManager default homeServices removeComponent: self named: aComponentName.
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> start [ 
	^MolUtils startComponent: self
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> start: aComponentName [
	^MolUtils startComponent: self named: aComponentName
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> stop [
	^MolUtils stopComponent: self
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> stop: aComponentName [
	^MolUtils stopComponent: self named: aComponentName
]

{ #category : #deployment }
MolComponentImpl classSide >> undeploy [
	^MolComponentManager default deploymentServices undeployComponentImplementation: self.
]

{ #category : #'component life cycle' }
MolComponentImpl >> componentActivate [
	"here write the code corresponding to component activation phase"
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentConnector [
	^ componentConnector
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentConnector: aConnector [
	"set a connector to a component, release previous if necessary"

	(componentConnector notNil and: [ componentConnector ~= aConnector ])
		ifTrue: [ 
			componentConnector disconnectComponent: self.
			componentConnector release.
		].
	
	componentConnector := aConnector.
	aConnector ifNotNil: [ aConnector connectComponent: self ]
]

{ #category : #'component life cycle' }
MolComponentImpl >> componentInitialize [
	"here write the code corresponding to component initialisation phase"
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentName [

	^ componentName
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentName: aSymbol [

	componentName := aSymbol
]

{ #category : #'component life cycle' }
MolComponentImpl >> componentPassivate [
	"here write the code corresponding to component passivation phase"
]

{ #category : #'component life cycle' }
MolComponentImpl >> componentRemove [
	"here write the code corresponding to component remove phase"
]

{ #category : #'private component accessing' }
MolComponentImpl >> eventsNotifiers [
	^ self componentConnector
		ifNotNil: [ :e | e eventsNotifiers ]
		ifNil: [ MolComponentConnector defaultEventsNotifiers ]
]

{ #category : #'private component accessing' }
MolComponentImpl >> eventsSubscribers [
	^ self componentConnector
		ifNotNil: [ :e | e eventsSubscribers ]
		ifNil: [ MolComponentConnector defaultEventsSubscribers ]
]

{ #category : #'component connecting' }
MolComponentImpl >> forEvents: anEventsTrait removeProducer: aComponentName [
	| producers |
	producers := self eventsSubscribers at: anEventsTrait.
	producers isArray 
		ifTrue: [ producers remove: aComponentName ifAbsent:[nil]]
		ifFalse: [self eventsSubscribers removeKey: anEventsTrait ifAbsent:[nil]]
]

{ #category : #'component connecting' }
MolComponentImpl >> forEvents: anEventsTrait useAllProducers: aComponentNameList [
	self eventsSubscribers at: anEventsTrait put: aComponentNameList
]

{ #category : #'component connecting' }
MolComponentImpl >> forEvents: anEventsTrait useProducer: aComponentName [
	(anEventsTrait traits includes: MolComponentEvents)
		ifTrue: [self eventsSubscribers at: anEventsTrait put: aComponentName]
		ifFalse: [ MolUtils log: self printString, '>forEvent:useProducer: try to link a non event trait for an event ' ]
]

{ #category : #'component connecting' }
MolComponentImpl >> forParameters: aParametersTrait useProvider: aComponentName [
	(aParametersTrait traits includes: MolComponentParameters)
		ifTrue: [self parametersProviders at: aParametersTrait put: aComponentName]
		ifFalse: [ MolUtils log: self printString, '>forParameters:useProvider: try to link a non parameters trait for parameters ' ]
]

{ #category : #'component connecting' }
MolComponentImpl >> forServices: aServicesTrait useProvider: aComponentName [
	(aServicesTrait traits includes: MolComponentServices)
		ifTrue: [self servicesProviders at: aServicesTrait put: aComponentName]
		ifFalse: [ MolUtils log: self printString, '>forService:useProvider: try to link a non services trait for services ' ]
]

{ #category : #testing }
MolComponentImpl >> isComponent [
	^ true
]

{ #category : #testing }
MolComponentImpl >> isNotFoundParameters [
	^false
]

{ #category : #testing }
MolComponentImpl >> isNotFoundServices [
	^false
]

{ #category : #'private component accessing' }
MolComponentImpl >> parametersProviders [
	^ self componentConnector
		ifNotNil: [ :e | e parametersProviders ]
		ifNil: [ MolComponentConnector defaultParametersProviders ]
]

{ #category : #'private component accessing' }
MolComponentImpl >> servicesProviders [
	^ self componentConnector
		ifNotNil: [ :e | e servicesProviders ]
		ifNil: [ MolComponentConnector defaultServicesProviders ]
]
