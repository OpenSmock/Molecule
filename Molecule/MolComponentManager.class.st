"
I am responsable for manage all the instances of the system. I have a deploymentServices, a homeServices and a locatorServices to manage components.

This component framework is based on Lightweight CCM (CORBA Component Model). It allows to have an architecture driven by components.
"
Class {
	#name : #MolComponentManager,
	#superclass : #Object,
	#instVars : [
		'deploymentServices',
		'locatorServices',
		'homeServices'
	],
	#classVars : [
		'Default'
	],
	#category : #'Molecule-Core'
}

{ #category : #'initialize-release' }
MolComponentManager class >> cleanUp [
	<script: 'self cleanUp'>
	| notifiers subscribers |

	"CleanUp and initialize the ComponentFactory"
	MolComponentFactory cleanUp.
	MolComponentFactory initialize.
	
	Default ifNil:[^self].
	Default locatorServices eventsSubscribers: nil.

	notifiers := MolEventNotifier allInstances.
	subscribers := MolEventSubscriber allInstances.

	Default release.
	Default := nil.
	notifiers do: [:n | n release].
	subscribers do: [:n | n release].
	
	
]

{ #category : #'initialize-release' }
MolComponentManager class >> deepCleanUp [
	<script: 'self deepCleanUp'>
	| i j |
	self cleanUp.
	MolComponentFactory allInstancesDo: [ :factory | (factory == MolComponentFactory default) ifFalse:[factory release]].
	i := self flushComponents.
	j := i.

	SmalltalkImage cleanUp.
	Smalltalk garbageCollect.
	Smalltalk garbageCollectMost.
	
	"Try to reflush"
	i > 0 ifTrue:[
		(Delay forMilliseconds: 500) wait.
		j := self flushComponents.	
	].
	
	MolUtils log: 'Deep Cleanup: ',i printString,' lost component(s) found and released.'.
	i <= 0 ifFalse:[
		j <= 0 ifFalse:[
			MolUtils showInformation: 'Warning : Cannot release ',i printString,' component(s) after two clean pass, please try again to confirm correct cleanup.'.
		] ifTrue:[
			MolUtils showInformation: 'Clean success : ',i printString,' lost component(s) found and released.'.
		].
	] ifTrue:[
		MolUtils showInformation: 'No problem : image was clean.'.
	].
]

{ #category : #singleton }
MolComponentManager class >> default [
	<script: 'self default inspect'>
	
	Default ifNil: [Default := self new].
	^Default
]

{ #category : #'initialize-release' }
MolComponentManager class >> flushComponents [
	"Flush all components an return number of flushed components"
	| i |
	i := 0.
	MolAbstractComponentImpl allSubInstancesDo:[ :component | component componentFlush. i := i + 1 ].
	MolComponentImpl users do: [:impl | impl allInstances do: [:component | component componentFlush. i := i + 1]].
	^i
]

{ #category : #'initialize-release' }
MolComponentManager class >> isRunningComponents [
	<script:'self isRunningComponents inspect'>
	"Test if somes components are present to define a running Component System"
	
	Default ifNotNil:[
		^Default homeServices deployedComponents notEmpty
	].
	^false
]

{ #category : #'initialize-release' }
MolComponentManager >> cleanUp [

	self class cleanUp.
	
]

{ #category : #accessing }
MolComponentManager >> deploymentServices [

	^ deploymentServices
]

{ #category : #accessing }
MolComponentManager >> homeServices [

	^ homeServices
]

{ #category : #'initialize-release' }
MolComponentManager >> initialize [

	super initialize.

	MolComponentFactory initialize.

	deploymentServices := MolDeploymentServices new.
	locatorServices := MolLocatorServices new.
	homeServices := MolHomeServices new.
]

{ #category : #accessing }
MolComponentManager >> locatorServices [

	^ locatorServices
]

{ #category : #'initialize-release' }
MolComponentManager >> release [
	
	deploymentServices release.
	locatorServices release.
	homeServices release.
	
	deploymentServices := nil.
	locatorServices := nil.
	homeServices := nil.
	
	super release.
]
