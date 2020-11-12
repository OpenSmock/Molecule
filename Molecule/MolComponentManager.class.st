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
	Default homeServices release.
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
	| i |

	self cleanUp.
	self flag:'PLA : missing MolComponentFactory cleanUp ? Where is it ?'.
	i := 0.
	MolComponentImpl users do: [:impl | impl allInstances do: [:component | component componentFlush. i := i+1]].
	MolUtils log: 'ComponentManager deepCleanup: ',i printString,' instance(s) found and released.'.
]

{ #category : #singleton }
MolComponentManager class >> default [

	Default ifNil: [Default := self new initialize].
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
