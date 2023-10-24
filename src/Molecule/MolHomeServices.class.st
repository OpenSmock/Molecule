"
I am responsible for manage components life cycle. 

When a component is instanciated, it is initialized. After, you can alternatively activate and passivate a component as you want. At system closure, all the components are passivate, then removed.

See examples of my use in Tests and Examples packages.

"
Class {
	#name : #MolHomeServices,
	#superclass : #Object,
	#instVars : [
		'deployedComponents',
		'waitingForActivation'
	],
	#category : #'Molecule-Core'
}

{ #category : #'life cycle' }
MolHomeServices >> activateAllComponents [
	| waitingComponents |
	
	waitingComponents := waitingForActivation copy.
	waitingComponents do: [ :component |
		self activateComponent: component class named: component componentName.
	]
]

{ #category : #'life cycle' }
MolHomeServices >> activateComponent: aComponentClass [

	^ self activateComponent: aComponentClass named: MolUtils defaultComponentName
]

{ #category : #'life cycle' }
MolHomeServices >> activateComponent: aComponentClass named: aName [
	| component |
	
	self assert: [aComponentClass isNotNil] description: ['[Molecule] Component class should be not nil.'].
	self assert: [aName isNotNil] description: ['[Molecule] Component name should be not nil.'].
	
	"get to be activated component instance"
	component := self instanceOf: aComponentClass named: aName.
	component ifNil:[
		^ComponentNotFoundError signal: 'Can not activate a non instanciated component'.
	].
	
	"remove from waiting activation list"
	waitingForActivation
		remove: component
		ifAbsent: [ ^ComponentAlreadyActivatedError signal: 'Component is already activated.' ].
		
	component componentConnector activateComponent.
	
	"Manage connexion between components"
	MolComponentManager default locatorServices resolveWaitingSubscriptions: component.
	
	component componentActivate.
	component triggerEvent: #activateComponent with: component.
	
	MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' is activated.'.
	
	^ component
]

{ #category : #private }
MolHomeServices >> addDeployedComponent: aComponentClass [
	self deployedComponents at: aComponentClass ifAbsentPut: [Dictionary new]
]

{ #category : #private }
MolHomeServices >> checkInstantiationOfComponent: aComponentClass named: aComponentName [

	| deployed component overridedTypes |
	aComponentName ifNil: [
		^ WrongComponentNameError new messageText:
			  'Can not instantiate a component without name' ].

	aComponentName isSymbol ifFalse: [
		^ WrongComponentNameError new messageText:
			  'Can not instantiate a component with a name wish is not a symbol' ].

	deployed := self deployedComponents at: aComponentClass ifAbsent: [
		            ^ ComponentNotDeployedError new messageText:
			              'Can not instantiate a non deployed component' ].
	deployed at: aComponentName ifPresent: [ :e |
		e ifNotNil: [
			^ ComponentAlreadyExistsError new messageText:
				  'Can not instantiate a component with the same name of another component, please change the name of the component' ] ].

	component := MolComponentManager default locatorServices
		             searchComponentTypeImplementorFor:
		             aComponentClass componentType
		             named: aComponentName.
	component ifNotNil: [
		^ ComponentAlreadyExistsError new messageText:
			  'Can not instantiate a component with the same type and name of another component, please change the name of the component' ].

	aComponentClass componentType allProvidedServices do: [ :e |
		(MolComponentManager default locatorServices
			 searchServicesProviderFor: e
			 named: aComponentName) isNotFoundServices ifFalse: [
			^ ComponentProvidedServicesAlreadyExistsError new messageText:
				  'Can not instantiate a component with the same services and name of another component, please change the name of the component' ] ].

	aComponentClass componentType allProvidedParameters do: [ :e |
		(MolComponentManager default locatorServices
			 searchParametersProviderFor: e
			 named: aComponentName) isNotFoundParameters ifFalse: [
			^ ComponentProvidedParametersAlreadyExistsError new messageText:
				  'Can not instantiate a component with the same parameters and name of another component, please change the name of the component' ] ].

	aComponentClass isOverrideComponentType ifTrue: [
		overridedTypes := aComponentClass overridedComponentTypes.
		overridedTypes do: [ :type |
			type allProvidedServices do: [ :e |
				(MolComponentManager default locatorServices
					 searchServicesProviderFor: e
					 named: aComponentName) isNotFoundServices ifFalse: [
					^ ComponentProvidedServicesAlreadyExistsError new messageText:
						  '(Inheritance problem) Can not instantiate a component with the same services and name of another component, please change the name of the component' ] ].
			type allProvidedParameters do: [ :e |
				(MolComponentManager default locatorServices
					 searchParametersProviderFor: e
					 named: aComponentName) isNotFoundParameters ifFalse: [
					^ ComponentProvidedServicesAlreadyExistsError new messageText:
						  '(Inheritance problem) Can not instantiate a component with the same parameters and name of another component, please change the name of the component' ] ] ] ].
	^ nil
]

{ #category : #accessing }
MolHomeServices >> deployedComponents [
	^ deployedComponents
]

{ #category : #'initialize-release' }
MolHomeServices >> initialize [
	super initialize.
	deployedComponents := Dictionary new.
	waitingForActivation := Set new.
]

{ #category : #accessing }
MolHomeServices >> instanceOf: aClass named: aName [
	^(self deployedComponents at: aClass ifAbsent: [^nil]) at: aName ifAbsent: [^nil]
]

{ #category : #'life cycle' }
MolHomeServices >> instanciateAllComponents [

	self deprecated: 'Use instantiateAllComponents'
		transformWith: '`@receiver instanciateAllComponents' -> '`@receiver instantiateAllComponents'.
	self instantiateAllComponents
]

{ #category : #'life cycle' }
MolHomeServices >> instanciateComponent: aComponentClass [

	self deprecated: 'Use instantiateComponent:'
		transformWith: '`@receiver instanciateComponent: `@aComponentClass' -> '`@receiver instantiateComponent: `@aComponentClass'.
	^ self instantiateComponent: aComponentClass
]

{ #category : #'life cycle' }
MolHomeServices >> instanciateComponent: aComponentClass named: aName [

	self deprecated: 'Use instantiateComponent: named:'
		transformWith: '`@receiver instanciateComponent: `@aComponentClass named: `@aName' ->'`@receiver instantiateComponent: `@aComponentClass named: `@aName'.
	^ self instantiateComponent: aComponentClass named: aName
]

{ #category : #'life cycle' }
MolHomeServices >> instantiateAllComponents [

	self deployedComponents keysDo: [ :aClass |
		self instantiateComponent: aClass ]
]

{ #category : #'life cycle' }
MolHomeServices >> instantiateComponent: aComponentClass [

	^ self instantiateComponent: aComponentClass named: MolUtils defaultComponentName
]

{ #category : #'life cycle' }
MolHomeServices >> instantiateComponent: aComponentClass named: aName [

	| error component connector deployed |
	aComponentClass ifNil: [ ^ nil ].
	error := self
		         checkInstantiationOfComponent: aComponentClass
		         named: aName.
	error ifNotNil: [
		error signal.
		^ nil ].

	component := aComponentClass new
		             componentName: aName;
		             yourself.
	MolUtils log:
		aComponentClass printString , ' named: ' , aName printString
		, ' is instantiated.'.

	deployed := self deployedComponents at: aComponentClass.
	deployed at: component componentName put: component.

	"connect the component to the component model and initialize it"
	connector := MolComponentConnector new.
	component componentConnector: connector.
	component componentInitialize.
	component triggerEvent: #instantiateComponent with: component.

	"add the component to waiting activation list"
	waitingForActivation add: component.

	^ component
]

{ #category : #private }
MolHomeServices >> isDeployedComponent: aComponentClass [

	^ self deployedComponents includesKey: aComponentClass
]

{ #category : #testing }
MolHomeServices >> isWaitingForActivation: aComponentClass [

	^ self isWaitingForActivation: aComponentClass named: MolUtils defaultComponentName
]

{ #category : #testing }
MolHomeServices >> isWaitingForActivation: aComponentClass named: aComponentName [
	| component |

	component := self instanceOf: aComponentClass named: aComponentName.
	component isNil
		ifFalse: [^waitingForActivation includes: component]
		ifTrue: [^false]
]

{ #category : #'life cycle' }
MolHomeServices >> passivateAllComponents [
	self deployedComponents do: [ :aDictionary | 
		aDictionary keysAndValuesDo: [ :aName :aComponent | 
			(waitingForActivation includes: aComponent) ifFalse: [self passivateComponent: aComponent class named: aName]
		]
	]
]

{ #category : #'life cycle' }
MolHomeServices >> passivateComponent: aComponentClass [

	^ self passivateComponent: aComponentClass named: MolUtils defaultComponentName
]

{ #category : #'life cycle' }
MolHomeServices >> passivateComponent: aComponentClass named: aName [
	| component |
	
	(aComponentClass isNil or:[aName isNil]) ifTrue:[^self].
		
	"get to be passivated component instance"
	component := self instanceOf: aComponentClass named: aName.
	component ifNil: [
		^ComponentNotFoundError signal: 'Can not passivate a non instanciated component'.
	].

	(self isWaitingForActivation: aComponentClass named: aName) ifTrue:[
		^ComponentAlreadyPassivatedError signal: 'Component is already passivated.' 
	].

	component componentPassivate.
	component componentConnector passivateComponent.
	component triggerEvent: #passivateComponent with: component.
	
	MolUtils log: aComponentClass printString , ' named: ' , aName printString, ' is passivated.'.

	"add in waiting activation list"
	waitingForActivation add: component.
	
	^ component
]

{ #category : #'initialize-release' }
MolHomeServices >> release [
	self removeAllComponents.
	deployedComponents := nil.
	waitingForActivation := nil.
	super release.
]

{ #category : #'life cycle' }
MolHomeServices >> removeAllComponents [
	| components |
	components := self deployedComponents.
	components keysAndValuesDo: [ :key :values | 
		values copy do:[ :component | self removeComponent: key named: component componentName]
	]
]

{ #category : #'life cycle' }
MolHomeServices >> removeComponent: aComponentClass [

	^ self removeComponent: aComponentClass named: MolUtils defaultComponentName
]

{ #category : #'life cycle' }
MolHomeServices >> removeComponent: aComponentClass named: aName [
	| removedComponent deployedComponentsOfThisClass |
	(aComponentClass isNil or:[aName isNil]) ifTrue:[^nil].
	
	"Get to be removed component instance"
	removedComponent := self instanceOf: aComponentClass named: aName.
	removedComponent ifNil:[ ComponentNotFoundError signal: 'Can not remove a non instanciated component'. ^nil ].
	
	"Passivation of the component if activated"
	(self isWaitingForActivation: aComponentClass named: aName) ifFalse: [ self passivateComponent: aComponentClass named: aName ].
	waitingForActivation remove: removedComponent ifAbsent:[
		"The Component has not been activated, log and proceed to the remove"
		MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' has not been activated during the session.'.
	].
	
	"Remove the component"
	removedComponent componentRemove.
	removedComponent componentConnector: nil.
	removedComponent triggerEvent: #removeComponent with: removedComponent.
	
	"Get deployed component instances of this component class"
	deployedComponentsOfThisClass := self deployedComponents at: aComponentClass ifAbsent:[
		MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' is not a deployed component class.'.
	].
	
	"Remove the instance"
	deployedComponentsOfThisClass removeKey: aName ifAbsent: [ 
		MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' is not a deployed component class.'.
	].

	"Resolve connections between components"
	"Unlink component connection between this old component and not yet activated components"
	waitingForActivation do: [ :waitingComponent | self resetComponentConnection: waitingComponent withRemovedComponent: removedComponent ].
	"Unlink component connection between this old component and activated components"	
	self deployedComponents keysAndValuesDo: [ :class :componentDictionary | 
		componentDictionary valuesDo: [ :activatedComponent | 
			self resetComponentConnection: activatedComponent withRemovedComponent: removedComponent.
		] 
	].
	
	"Finish release of the component life-cycle"
	removedComponent componentName: nil.
	MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' is removed.'.
	^removedComponent
]

{ #category : #private }
MolHomeServices >> removeDeployedComponent: aComponentClass [
	"Remove a deployed component"
	self deployedComponents at: aComponentClass ifPresent:[ :compDict | 
		"Check if this component class have running instances"
		compDict isEmpty 
			ifTrue:[self deployedComponents removeKey: aComponentClass] 
			ifFalse:[
				"Remove existing components"
				compDict copy keysAndValuesDo: [ :k :v | self removeComponent: (v class) named: k ].
			].
	] ifAbsent:[ ^self ].
]

{ #category : #private }
MolHomeServices >> resetComponentConnection: aComponent withRemovedComponent: aRemovedComponent [
	"Unlink component connections with a removed component, this action reset component connexion in case of a new instance appears"
	| eventAndComponentNameAssocList eventsSubscribers |
	
	self flag:'PLA : test it'.
	(aComponent isNil or:[aRemovedComponent isNil]) ifTrue:[ ^ self ].
	eventsSubscribers := MolComponentManager default locatorServices eventsSubscribers.
	eventsSubscribers ifEmpty: [ ^ self ].
	
	eventAndComponentNameAssocList := aRemovedComponent class allProducedEvents collect: [ :event | 
		event -> aRemovedComponent componentName
	].

	eventAndComponentNameAssocList do: [ :eventAndComponentNameAssoc |
		
		eventsSubscribers keysAndValuesDo:[ :anEventInterface :eventSubscriber |
			
			(anEventInterface = eventAndComponentNameAssoc key) ifTrue:[ 
				
				eventSubscriber notNil ifTrue:[ | newObserversSet |
					
					eventSubscriber unlinkOriginator: aRemovedComponent.
					newObserversSet := eventSubscriber observersConnection at: aComponent ifAbsent:[ nil ].
					newObserversSet ifNotNil:[
						newObserversSet remove: aComponent componentName ifAbsent:[ nil ].
						eventSubscriber observersConnection at: aComponent put: newObserversSet.
					].
				]. 
			].	
		].
	].
]

{ #category : #accessing }
MolHomeServices >> waitingForActivation [
	^ waitingForActivation
]
