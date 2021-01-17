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
	MolUtils log: 'Starting a cleanUp.'.

	"CleanUp and initialize the ComponentFactory"
	MolComponentFactory cleanUp.
	MolComponentFactory initialize.
	
	Default ifNil:[MolUtils log: 'End of the cleanUp.'. ^self].
	Default locatorServices eventsSubscribers: nil.

	notifiers := MolEventNotifier allInstances.
	subscribers := MolEventSubscriber allInstances.

	"Ignore some Error during the cleanUp because the clean process can be different of the start order"
	[Default release] on: ComponentAlreadyPassivatedError, ComponentNotFoundError do:[ :e | 
		"Just log"
		MolUtils log: 'Error during the cleanUp : ', e printString , ', this error may be normal during a cleanUp.'. 
	].
	Default := nil.

	notifiers do: [:n | n release].
	subscribers do: [:n | n release].
	MolUtils log: 'End of the cleanUp.'.
	
]

{ #category : #'initialize-release' }
MolComponentManager class >> deepCleanUp [
	<script: 'self deepCleanUp'>
	| i j |
	self cleanUp.
	MolUtils log: 'Starting a deep cleanUp.'.
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

	MolUtils log: 'End of the deep cleanUp.'.
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
	MolAbstractComponentImpl allSubInstancesDo:[ :component | component componentConnector: nil. i := i + 1 ].
	MolComponentImpl users do: [:impl | impl allInstances do: [:component | component componentConnector: nil. i := i + 1]].	
	^i
]

{ #category : #'initialize-release' }
MolComponentManager class >> isRunningComponents [
	<script:'self isRunningComponents inspect'>
	"Test if somes components are started and running"
	
	Default ifNotNil:[ | components |
		components := Default homeServices deployedComponents.
		components ifNil:[ ^false ].
		components valuesDo: [ :aDictionary | aDictionary notEmpty ifTrue:[ ^true ] ].
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
