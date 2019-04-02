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
	#category : #'Molecule-Core'
}

{ #category : #'component creation' }
MolUtils class >> createAllComponents [
	"instanciate and activate all deployed components"
	"self createAllComponents"

	| homeServices components |
	homeServices := MolComponentManager default homeServices.
	components := homeServices deployedComponents.
	components keysDo: [ :aClass | homeServices instanciateComponent: aClass ].
	components keysDo: [ :aClass | homeServices activateComponent: aClass ]
]

{ #category : #'component creation' }
MolUtils class >> defineAllComponents [
	"define all components subsclasses"
	"self defineAllComponents"

	MolAbstractComponentImpl allSubclassesDo: [ :c | c defineComponent ]
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
MolUtils class >> isInstanciateComponentOf: aClass [

	^ self isInstanciateComponentOf: aClass named: #default
]

{ #category : #testing }
MolUtils class >> isInstanciateComponentOf: aClass named: aName [

	^ (MolComponentManager default homeServices instanceOf: aClass named: aName) notNil
]

{ #category : #accessing }
MolUtils class >> isLogActive [
	"self isLogActive"

	isLogActive isNil ifTrue:[isLogActive := false].
	^ isLogActive
]

{ #category : #accessing }
MolUtils class >> isLogActive: aBoolean [

	isLogActive := aBoolean
]

{ #category : #log }
MolUtils class >> log: aString [

	self isLogActive ifTrue: [ self traceCr: '[Molecule] ', aString ]
]

{ #category : #'component easy start' }
MolUtils class >> startComponent: aComponentClass [
	"deploy, instanciate and activate quickly a component"

	^ self startComponent: aComponentClass named: #default
]

{ #category : #'component easy start' }
MolUtils class >> startComponent: aComponentClass named: aName [
	"deploy, instanciate and activate quickly a component"

	| component |
	MolComponentManager default deploymentServices deployComponentImplementation: aComponentClass.
	component := MolComponentManager default homeServices instanciateComponent: aComponentClass named: aName.
	MolComponentManager default homeServices activateComponent: aComponentClass named: aName.
	^ component
]

{ #category : #actions }
MolUtils class >> toggleLog [
	"self toggleLog"

	self isLogActive: self isLogActive not.
	self traceCr: '[Molecule] Log status changed to : ', self isLogActive printString.
]
