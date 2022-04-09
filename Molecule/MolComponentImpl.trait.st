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
	#category : #'Molecule-Component'
}

{ #category : #'life cycle' }
MolComponentImpl classSide >> activate [

	^ MolComponentManager default homeServices activateComponent: self
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> activate: aComponentName [

	^ MolComponentManager default homeServices activateComponent: self named: aComponentName
]

{ #category : #testing }
MolComponentImpl classSide >> componentType [

	"get all hierarchy traits and try to detect a component type"
	self withAllSuperclassesDo: [ :c | 
		(c  ~= MolAbstractComponentImpl and:[c ~= Object and:[c ~= ProtoObject]]) ifTrue:[
			(c traitComposition allTraits) do:[ :t | t isComponentType ifTrue:[ ^t ] ].
		].
	].
	"^(traits detect:[ :t | t isComponentType] ifNone:[nil])"
	^ nil
]

{ #category : #definition }
MolComponentImpl classSide >> defineComponent [

	self removeProtocol: MolComponentFactory protocolForComponentAccess.
	MolComponentFactory defineComponent: self.

]

{ #category : #deployment }
MolComponentImpl classSide >> deploy [

	^ MolComponentManager default deploymentServices deployComponentImplementation: self
]

{ #category : #testing }
MolComponentImpl classSide >> haveComponentType [

	^ self componentType notNil
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> instanciate [

	^ MolComponentManager default homeServices instanciateComponent: self
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> instanciate: aComponentName [

	^ MolComponentManager default homeServices instanciateComponent: self named: aComponentName
]

{ #category : #testing }
MolComponentImpl classSide >> isComponentClass [

	^ true
]

{ #category : #testing }
MolComponentImpl classSide >> isOverrideComponentType [

	^ self overridedComponentTypes notEmpty
]

{ #category : #private }
MolComponentImpl classSide >> overridedComponentTypes [
	| traits componentType |

	traits := Set new.
	self withAllSuperclassesDo: [ :c | 
		(c  ~= MolAbstractComponentImpl and:[c ~= Object and:[c ~= ProtoObject]]) ifTrue:[traits addAll: c traitComposition allTraits].
	].
	componentType := self componentType.
	^(traits select:[ :t | t isComponentType and:[t ~= componentType] ]) asOrderedCollection 
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> passivate [

	^ MolComponentManager default homeServices passivateComponent: self
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> passivate: aComponentName [

	^ MolComponentManager default homeServices passivateComponent: self named: aComponentName
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> remove [

	^ MolComponentManager default homeServices removeComponent: self
]

{ #category : #'life cycle' }
MolComponentImpl classSide >> remove: aComponentName [

	^ MolComponentManager default homeServices removeComponent: self named: aComponentName
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> start [

	^ MolUtils startComponent: self
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> start: aComponentName [

	^ MolUtils startComponent: self named: aComponentName
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> stop [

	^ MolUtils stopComponent: self
]

{ #category : #'start & stop' }
MolComponentImpl classSide >> stop: aComponentName [

	^ MolUtils stopComponent: self named: aComponentName
]

{ #category : #deployment }
MolComponentImpl classSide >> undeploy [

	^ MolComponentManager default deploymentServices undeployComponentImplementation: self
]

{ #category : #'life cycle' }
MolComponentImpl >> componentActivate [
	"here write the code corresponding to component activation phase"
]

{ #category : #'private accessing' }
MolComponentImpl >> componentConnector [
	^ componentConnector
]

{ #category : #'private accessing' }
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

{ #category : #'life cycle' }
MolComponentImpl >> componentInitialize [
	"here write the code corresponding to component initialisation phase"
]

{ #category : #accessing }
MolComponentImpl >> componentName [

	^ componentName
]

{ #category : #'private accessing' }
MolComponentImpl >> componentName: aSymbol [

	componentName := aSymbol
]

{ #category : #'life cycle' }
MolComponentImpl >> componentPassivate [
	"here write the code corresponding to component passivation phase"
]

{ #category : #'life cycle' }
MolComponentImpl >> componentRemove [
	"here write the code corresponding to component remove phase"
]

{ #category : #'private accessing' }
MolComponentImpl >> eventsNotifiers [
	^ self componentConnector
		ifNotNil: [ :e | e eventsNotifiers ]
		ifNil: [ MolComponentConnector defaultEventsNotifiers ]
]

{ #category : #'private accessing' }
MolComponentImpl >> eventsSubscribers [
	^ self componentConnector
		ifNotNil: [ :e | e eventsSubscribers ]
		ifNil: [ MolComponentConnector defaultEventsSubscribers ]
]

{ #category : #'connecting - events producers' }
MolComponentImpl >> forEvents: anEventsTrait removeProducer: aComponentName [

	| producers |
	
	(anEventsTrait traits includes: MolComponentEvents) ifTrue: [
		
		producers := self eventsSubscribers at: anEventsTrait.
		producers ifNil:[ ^self ].
		producers = aComponentName ifTrue:[ self eventsSubscribers at: anEventsTrait put: nil. ^ self ].
		(producers isArray and:[producers includes: aComponentName]) ifTrue: [
			producers := producers asOrderedCollection.
			producers remove: aComponentName. 
			^ self forEvents: anEventsTrait useAllProducers: producers
		].
		
	] ifFalse: [ MolUtils log: self printString , '>forEvent:useProducer: try to link a non event trait for an event ' ].
]

{ #category : #'connecting - events producers' }
MolComponentImpl >> forEvents: anEventsTrait useAllProducers: aComponentNameList [

	| anArrayOrComponentName |
	
	(anEventsTrait traits includes: MolComponentEvents) ifTrue: [
			
		anArrayOrComponentName := (aComponentNameList isCollection and:[aComponentNameList notEmpty]) 
			ifTrue:[ aComponentNameList size = 1 ifTrue: [ aComponentNameList asOrderedCollection first ] ifFalse: [ aComponentNameList asArray ]] 
			ifFalse:[ nil ].
	
		self eventsSubscribers at: anEventsTrait put: anArrayOrComponentName
			
	] ifFalse: [ MolUtils log: self printString , '>forEvent:useAllProducers: try to link a non event trait for an event ' ].
	
	
]

{ #category : #'connecting - events producers' }
MolComponentImpl >> forEvents: anEventsTrait useProducer: aComponentName [

	(anEventsTrait traits includes: MolComponentEvents)
		ifTrue: [ self eventsSubscribers at: anEventsTrait put: aComponentName ]
		ifFalse: [ MolUtils log: self printString , '>forEvent:useProducer: try to link a non event trait for an event ' ]
]

{ #category : #'connecting - parameters providers' }
MolComponentImpl >> forParameters: aParametersTrait useProvider: aComponentName [

	(aParametersTrait traits includes: MolComponentParameters)
		ifTrue: [self parametersProviders at: aParametersTrait put: aComponentName]
		ifFalse: [ MolUtils log: self printString, '>forParameters:useProvider: try to link a non parameters trait for parameters ' ]
]

{ #category : #'connecting - services providers' }
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

{ #category : #'private accessing' }
MolComponentImpl >> parametersProviders [
	^ self componentConnector
		ifNotNil: [ :e | e parametersProviders ]
		ifNil: [ MolComponentConnector defaultParametersProviders ]
]

{ #category : #'private accessing' }
MolComponentImpl >> servicesProviders [
	^ self componentConnector
		ifNotNil: [ :e | e servicesProviders ]
		ifNil: [ MolComponentConnector defaultServicesProviders ]
]
