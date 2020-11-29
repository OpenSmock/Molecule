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

	Default ifNil:[^self].
	Default locatorServices eventsSubscribers: nil.

	notifiers := MolEventNotifier allInstances.
	subscribers := MolEventSubscriber allInstances.

	Default release.
	Default := nil.
	notifiers do: [:n | n release].
	subscribers do: [:n | n release].
	
	MolComponentFactory initialize.
]

{ #category : #'initialize-release' }
MolComponentManager class >> deepCleanUp [
	<script: 'self deepCleanUp'>
	| i |
	self cleanUp.
	
	i := 0.
	MolComponentFactory allInstancesDo: [ :factory | (factory == MolComponentFactory default) ifFalse:[factory release]].
	MolAbstractComponentImpl allSubInstancesDo:[ :component | component componentFlush. i := i+1 ].
	MolComponentImpl users do: [:impl | impl allInstances do: [:component | component componentFlush. i := i+1]].
	SmalltalkImage cleanUp.
	self inform: '[Molecule] Deep Cleanup : ',i printString,' lost component(s) found and released.'.
	MolUtils log: 'Deep Cleanup: ',i printString,' lost component(s) found and released.'.
]

{ #category : #singleton }
MolComponentManager class >> default [
	<script: 'self default'>
	
	Default ifNil: [Default := self new].
	^Default
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

	MolComponentFactory cleanUp.
	
	deploymentServices release.
	locatorServices release.
	homeServices release.
	
	deploymentServices := nil.
	locatorServices := nil.
	homeServices := nil.
	
	super release.
]
