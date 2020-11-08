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

{ #category : #'component creation' }
MolUtils class >> createAllComponents [
	"instanciate and activate all deployed components"
	| homeServices components |
	
	homeServices := MolComponentManager default homeServices.
	components := homeServices deployedComponents.
	components keysDo: [ :aClass | homeServices instanciateComponent: aClass ].
	components keysDo: [ :aClass | homeServices activateComponent: aClass ]
]

{ #category : #'component creation' }
MolUtils class >> defineAllComponents [
	"define all components subsclasses"
	<script: 'self defineAllComponents'>

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
	<script: 'self inform: ''[Molecule] Is log active: '', self isLogActive printString'>

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

{ #category : #'component easy start and stop' }
MolUtils class >> startComponent: aComponentClass [
	"deploy, instanciate and activate quickly a component and return the instance"
	
	^ self startComponent: aComponentClass named: #default
]

{ #category : #'component easy start and stop' }
MolUtils class >> startComponent: aComponentClass named: aName [
	"deploy, instanciate and activate quickly a component and return the instance"
	| component |

	MolComponentManager default deploymentServices deployComponentImplementation: aComponentClass.
	component := MolComponentManager default homeServices instanciateComponent: aComponentClass named: aName.
	MolComponentManager default homeServices activateComponent: aComponentClass named: aName.
	
	^ component
]

{ #category : #'component easy start and stop' }
MolUtils class >> stopComponent: aComponentClass [
	"passivate, remove and undeploy quickly a component"
	
	^ self stopComponent: aComponentClass named: #default
]

{ #category : #'component easy start and stop' }
MolUtils class >> stopComponent: aComponentClass named: aName [
	"passivate, remove and undeploy quickly a component"

	MolComponentManager default homeServices passivateComponent: aComponentClass named: aName.
	MolComponentManager default homeServices removeComponent: aComponentClass named: aName.
	MolComponentManager default deploymentServices undeployComponentImplementation: aComponentClass.
]

{ #category : #actions }
MolUtils class >> toggleLog [
	<script: 'self toggleLog. self inform: ''[Molecule] Log status: '', self isLogActive printString'>

	self isLogActive: self isLogActive not.
]
