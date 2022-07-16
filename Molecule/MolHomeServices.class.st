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
	^ self activateComponent: aComponentClass named: #default
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
	component componentActivate.
	component triggerEvent: #activateComponent with: component.
	
	MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' is activated.'.
	
	"manage connexion between components"
	MolComponentManager default locatorServices resolveWaitingSubscriptions: component.
	
	^ component
]

{ #category : #private }
MolHomeServices >> addDeployedComponent: aComponentClass [
	self deployedComponents at: aComponentClass ifAbsentPut: [Dictionary new]
]

{ #category : #private }
MolHomeServices >> checkInstanciationOfComponent: arg1 named: arg2 [

	| tmp1 tmp2 tmp3 |
	arg2 ifNil: [ 
		^ WrongComponentNameError new messageText:
			  'Can not instanciate a component without name' ].
	arg2 isSymbol ifFalse: [ 
		^ WrongComponentNameError new messageText:
			  'Can not instanciate a component with a name wish is not a symbol' ].
	tmp1 := self deployedComponents at: arg1 ifAbsent: [ 
		        ^ ComponentNotDeployedError new messageText:
			          'Can not instanciate a non deployed component' ].
	tmp1 at: arg2 ifPresent: [ :arg3 | 
		arg3 ifNotNil: [ 
			^ ComponentAlreadyExistsError new messageText:
				  'Can not instanciate a component with the same name of another component, please change the name of the component' ] ].
	tmp2 := MolComponentManager default locatorServices
		        searchComponentTypeImplementorFor: arg1 componentType
		        named: arg2.
	tmp2 ifNotNil: [ 
		^ ComponentAlreadyExistsError new messageText:
			  'Can not instanciate a component with the same type and name of another component, please change the name of the component' ].
	arg1 componentType allProvidedServices do: [ :arg4 | 
		(MolComponentManager default locatorServices
			 searchServicesProviderFor: arg4
			 named: arg2) isNotFoundServices ifFalse: [ 
			^ ComponentProvidedServicesAlreadyExistsError new messageText:
				  'Can not instanciate a component with the same services and name of another component, please change the name of the component' ] ].
	arg1 componentType allProvidedParameters do: [ :arg5 | 
		(MolComponentManager default locatorServices
			 searchParametersProviderFor: arg5
			 named: arg2) isNotFoundParameters ifFalse: [ 
			^ ComponentProvidedParametersAlreadyExistsError new messageText:
				  'Can not instanciate a component with the same parameters and name of another component, please change the name of the component' ] ].
	arg1 isOverrideComponentType ifTrue: [ 
		tmp3 := arg1 overridedComponentTypes.
		tmp3 do: [ :arg6 | 
			arg6 allProvidedServices do: [ :arg7 | 
				(MolComponentManager default locatorServices
					 searchServicesProviderFor: arg7
					 named: arg2) isNotFoundServices ifFalse: [ 
					^ ComponentProvidedServicesAlreadyExistsError new messageText:
						  '(Inheritance problem) Can not instanciate a component with the same services and name of another component, please change the name of the component' ] ].
			arg6 allProvidedParameters do: [ :arg8 | 
				(MolComponentManager default locatorServices
					 searchParametersProviderFor: arg8
					 named: arg2) isNotFoundParameters ifFalse: [ 
					^ ComponentProvidedServicesAlreadyExistsError new messageText:
						  '(Inheritance problem) Can not instanciate a component with the same parameters and name of another component, please change the name of the component' ] ] ] ].
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
	self deployedComponents keysDo: [ :aClass | self instanciateComponent: aClass ]
]

{ #category : #'life cycle' }
MolHomeServices >> instanciateComponent: aComponentClass [
	^ self instanciateComponent: aComponentClass named: #default
]

{ #category : #'life cycle' }
MolHomeServices >> instanciateComponent: aComponentClass named: aName [
	| error component connector deployed |
	
	aComponentClass ifNil:[^nil].
	error := self checkInstanciationOfComponent: aComponentClass named: aName.
	error ifNotNil:[error signal. ^nil].
	
	component := aComponentClass new componentName: aName; yourself.
	MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' is instanciated.'.

	deployed := self deployedComponents at: aComponentClass.
	deployed at: component componentName put: component.
	
	"connect the component to the component model and initialize it"
	connector := MolComponentConnector new.
	component componentConnector: connector.
	component componentInitialize.
	component triggerEvent: #instanciateComponent with: component.
	
	"add the component to waiting activation list"
	waitingForActivation add: component.
	
	^component
]

{ #category : #private }
MolHomeServices >> isDeployedComponent: aComponentClass [

	^ self deployedComponents includesKey: aComponentClass
]

{ #category : #testing }
MolHomeServices >> isWaitingForActivation: aComponentClass [
	^ self isWaitingForActivation: aComponentClass named: #default
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
	^ self passivateComponent: aComponentClass named: #default
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
	^self removeComponent: aComponentClass named: #default
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
