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
	#category : #'Molecule-Core-Impl'
}

{ #category : #'component definition' }
MolComponentImpl classSide >> defineComponent [

	self removeProtocol: self protocolForComponentAccess.
	MolComponentFactory defineComponent: self.

]

{ #category : #testing }
MolComponentImpl classSide >> isComponent [
	^ true
]

{ #category : #'component definition' }
MolComponentImpl classSide >> protocolForComponentAccess [

	^'component accessing'
]

{ #category : #'component life cycle' }
MolComponentImpl >> componentActivate [
	"here write the code corresponding to component activation phase"
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentConnector [
	^ self explicitRequirement 
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentConnector: aConnector [
	^ self explicitRequirement 
]

{ #category : #'component life cycle' }
MolComponentImpl >> componentFlush [
	self componentConnector release.
]

{ #category : #'component life cycle' }
MolComponentImpl >> componentInitialize [
	"here write the code corresponding to component initialisation phase"
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentName [
	^ self explicitRequirement 
]

{ #category : #'private component accessing' }
MolComponentImpl >> componentName: aName [
	^ self explicitRequirement 
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
	^ self componentConnector eventsNotifiers
]

{ #category : #'private component accessing' }
MolComponentImpl >> eventsSubscribers [
	^ self componentConnector eventsSubscribers
]

{ #category : #'component connecting' }
MolComponentImpl >> forEvents: anEventsTrait removeProducer: aProducer [
	| producers |
	producers := self eventsSubscribers at: anEventsTrait.
	producers isArray 
		ifTrue: [ producers remove: aProducer ifAbsent:[nil]]
		ifFalse: [self eventsSubscribers removeKey: anEventsTrait ifAbsent:[nil]]
]

{ #category : #'component connecting' }
MolComponentImpl >> forEvents: anEventsTrait useAllProducers: aProducerList [
	self eventsSubscribers at: anEventsTrait put: aProducerList
]

{ #category : #'component connecting' }
MolComponentImpl >> forEvents: anEventsTrait useProducer: aProducer [
	(anEventsTrait traits includes: MolComponentEvents)
		ifTrue: [self eventsSubscribers at: anEventsTrait put: aProducer]
		ifFalse: [ MolUtils log: self printString, '>forEvent:useProducer: try to link a non event trait for an event ' ]
]

{ #category : #'component connecting' }
MolComponentImpl >> forParameters: aParametersTrait useProvider: aParametersProvider [
	(aParametersTrait traits includes: MolComponentParameters)
		ifTrue: [self parametersProviders at: aParametersTrait put: aParametersProvider]
		ifFalse: [ MolUtils log: self printString, '>forParameters:useProvider: try to link a non parameters trait for parameters ' ]
]

{ #category : #'component connecting' }
MolComponentImpl >> forServices: aServicesTrait useProvider: aServicesProvider [
	(aServicesTrait traits includes: MolComponentServices)
		ifTrue: [self servicesProviders at: aServicesTrait put: aServicesProvider]
		ifFalse: [ MolUtils log: self printString, '>forService:useProvider: try to link a non services trait for services ' ]
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
	^ self componentConnector parametersProviders
]

{ #category : #'private component accessing' }
MolComponentImpl >> servicesProviders [
	^ self componentConnector servicesProviders 
]
