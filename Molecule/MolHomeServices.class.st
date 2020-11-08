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

{ #category : #'component life cycle' }
MolHomeServices >> activateAllComponents [
	| waitingComponents |
	
	waitingComponents := waitingForActivation copy.
	waitingComponents do: [ :component |
		self activateComponent: component class named: component componentName.
	]
]

{ #category : #'component life cycle' }
MolHomeServices >> activateComponent: aComponentClass [
	^self activateComponent: aComponentClass named: #default
]

{ #category : #'component life cycle' }
MolHomeServices >> activateComponent: aComponentClass named: aName [
	| component |
	
	self assert: [aComponentClass isNotNil] description: ['[Molecule] Component class should be not nil.'].
	self assert: [aName isNotNil] description: ['[Molecule] Component name should be not nil.'].
	
	"get to be activated component instance"
	component := self instanceOf: aComponentClass named: aName.
	component isNil ifTrue:[
		ComponentNotFoundError signal: 'Can not activate a non instanciated component'.
	].
	
	"remove from waiting activation list"
	waitingForActivation
		remove: component
		ifAbsent: [ "don't activate a component already activated" ^ self ].
		
	component componentConnector activateComponent.
	component componentActivate.
	MolUtils log: aComponentClass printString , ' named: ' , aName printString , ' is activated.'.
	
	"manage connexion between components"
	MolComponentManager default locatorServices resolveWaitingSubscribtions: component.
	
	^ component
]

{ #category : #private }
MolHomeServices >> addDeployedComponent: aComponentClass [
	deployedComponents at: aComponentClass ifAbsentPut: [Dictionary new]
]

{ #category : #accessing }
MolHomeServices >> deployedComponents [
	^deployedComponents
]

{ #category : #'initialize-release' }
MolHomeServices >> initialize [
	super initialize.
	
	deployedComponents := Dictionary new.
	waitingForActivation := Set new
]

{ #category : #accessing }
MolHomeServices >> instanceOf: aClass named: aName [
	^(deployedComponents at: aClass ifAbsent: [^nil]) at: aName ifAbsent: [^nil]
]

{ #category : #'component life cycle' }
MolHomeServices >> instanciateAllComponents [
	self deployedComponents keysDo: [ :aClass | self instanciateComponent: aClass ]
]

{ #category : #'component life cycle' }
MolHomeServices >> instanciateComponent: aClass [
	^self instanciateComponent: aClass named: #default 
]

{ #category : #'component life cycle' }
MolHomeServices >> instanciateComponent: aClass named: aName [
	| component connector deployed |
	
	self assert: [aClass isNotNil] description: ['[Molecule] Component class should be not nil.'].
	self assert: [aName isNotNil] description: ['[Molecule] Component name should be not nil.'].
	
	"check if the component can be instanciate"
	deployed := deployedComponents at: aClass ifAbsent:[
		ComponentNotDeployedError signal: 'Can not instanciate a non deployed component'.	
	].
	
	"instanciate the component"
	component := aClass new componentName: aName; yourself.
	MolUtils log: aClass printString , ' named: ' , aName printString , ' is instanciated.'.
	deployed at: component componentName put: component.
	
	"connect the component to the component model and initialize it"
	connector := MolComponentConnector new.
	connector connectComponent: component.
	component componentInitialize.
	
	"add the component to waiting activation list"
	waitingForActivation add: component.
	
	^component
]

{ #category : #private }
MolHomeServices >> isDeployedComponent: aComponentClass [

	^ deployedComponents includesKey: aComponentClass
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

{ #category : #'component life cycle' }
MolHomeServices >> passivateAllComponents [
	deployedComponents do: [ :aDictionary | 
		aDictionary keysAndValuesDo: [ :aName :aComponent | 
			(waitingForActivation includes: aComponent) ifFalse: [self passivateComponent: aComponent class named: aName]
		]
	]
]

{ #category : #'component life cycle' }
MolHomeServices >> passivateComponent: aClass [
	^self passivateComponent: aClass named: #default
]

{ #category : #'component life cycle' }
MolHomeServices >> passivateComponent: aClass named: aName [
	| component |
	
	self assert: [aClass isNotNil] description: ['[Molecule] Component class should be not nil.'].
	self assert: [aName isNotNil] description: ['[Molecule] Component name should be not nil.'].
	
	"get to be passivated component instance"
	component := self instanceOf: aClass named: aName.
	component isNil ifTrue: [
		ComponentNotFoundError signal: 'Can not passivate a non instanciated component'.
	].

	component componentPassivate.
	component componentConnector passivateComponent.
	
	MolUtils log: aClass printString , ' named: ' , aName printString, ' is passivated.'.

	"add in waiting activation list"
	waitingForActivation add: component.
	
	^ component
]

{ #category : #'initialize-release' }
MolHomeServices >> release [
	super release.
	self removeAllComponents.

	deployedComponents := nil.
	waitingForActivation do: [ :comp |
		comp componentRemove.
		comp componentFlush 
	].
	waitingForActivation := nil.
]

{ #category : #'component life cycle' }
MolHomeServices >> removeAllComponents [
	| components |
	components := deployedComponents.
	components keysAndValuesDo:  [:key :values | 
		(values copy) do:[ :component | self removeComponent: key named: component componentName]
	]
]

{ #category : #'component life cycle' }
MolHomeServices >> removeComponent: aClass [ 
	self removeComponent: aClass named: #default
]

{ #category : #'component life cycle' }
MolHomeServices >> removeComponent: aClass named: aName [
	| component deployed |
	
	self assert: [aClass isNotNil] description: ['[Molecule] Component class should be not nil.'].
	self assert: [aName isNotNil] description: ['[Molecule] Component name should be not nil.'].
	
	"get to be removed component instance"
	component := self instanceOf: aClass named: aName.
	component isNil ifTrue:[
		ComponentNotFoundError signal: 'Can not remove a non instanciated component'.
	].
	
	"passivation if necessary"
	(self isWaitingForActivation: component) ifFalse: [ self passivateComponent: aClass named: aName ].
	
	waitingForActivation remove: component.
	
	component
		triggerEvent: #removeComponent with: component;
		componentRemove;
		componentFlush.
	waitingForActivation do: [ :waitingComponent | self resetComponentConnection: waitingComponent instance: component ].
	
	deployed := deployedComponents at: aClass ifAbsent:[
		MolUtils log: aClass printString , ' named: ' , aName printString , ' is not a deployed component class.'.
	].
	
	deployed removeKey: aName ifAbsent: [ 
		MolUtils log: aClass printString , ' named: ' , aName printString , ' is not a deployed component class.'.
	].
		
	deployedComponents keysAndValuesDo: [ :class :componentDictionary | 
		componentDictionary keysAndValuesDo: [ :name :value | 
			self resetComponentConnection: value instance: component 
		] 
	].
	
	MolUtils log: aClass printString , ' named: ' , aName printString , ' is removed.'.
	
	
]

{ #category : #private }
MolHomeServices >> removeDeployedComponent: aComponentClass [
	deployedComponents isEmpty ifTrue: [^self].
	deployedComponents removeKey: aComponentClass ifAbsent:[^self]
]

{ #category : #private }
MolHomeServices >> resetComponentConnection: aComponent instance: anUsedComponent [

	(aComponent isNil or:[anUsedComponent isNil]) ifTrue:[^self].

	"reset services connection"
	(aComponent servicesProviders includes: anUsedComponent)
		ifTrue: 
			[anUsedComponent class providedComponentServices do: 
					[:e |
					aComponent servicesProviders at: e
						ifPresent: [:i | aComponent servicesProviders at: e put: anUsedComponent componentName]]].

	"reset events connection"
	(aComponent eventsSubscribers includes: anUsedComponent)
		ifTrue: 
			[anUsedComponent class producedComponentEvents do: 
					[:e |
					aComponent eventsSubscribers at: e
						ifPresent: [:i | aComponent eventsSubscribers at: e put: anUsedComponent componentName]]].

	self flag:'PLA Patch provisoire pour débrancher et rebrancher à chaud un composant, à rendre robuste'.
	MolComponentManager default locatorServices waitSubscribtions: aComponent for: anUsedComponent.

	"reset parameters connection"
	(aComponent parametersProviders includes: anUsedComponent)
		ifTrue: 
			[anUsedComponent class providedComponentParameters do: 
					[:e |
					aComponent parametersProviders at: e
						ifPresent: [:i | aComponent parametersProviders at: e put: anUsedComponent componentName]]].
]
