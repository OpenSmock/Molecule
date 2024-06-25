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

{ #category : #cleanup }
MolComponentManager class >> cleanUp [

	<script: 'self cleanUp'>
	| notifiers subscribers |
	MolUtils log: 'Starting a cleanUp.'.

	"CleanUp and initialize a new ComponentFactory instance"
	MolComponentFactory cleanUp.
	MolComponentFactory initialize.

	Default ifNil: [ 
		MolUtils log: 'End of the cleanUp.'.
		^ self ].
	Default locatorServices eventsSubscribers: nil.

	notifiers := MolEventNotifier allInstances.
	subscribers := MolEventSubscriber allInstances.

	"Ignore some Error during the cleanUp because the clean process can be different of the start order"
	[ Default release ]
		on: ComponentAlreadyPassivatedError , ComponentNotFoundError
		do: [ :e | "Just log"
			MolUtils log: 'Error during the cleanUp : ' , e printString
				, ', this error may be normal during a cleanUp.' ].
	Default := nil.

	notifiers do: [ :n | n release ].
	subscribers do: [ :n | n release ].
	
	self cleanupMolAnnouncements.
	
	MolUtils log: 'End of the cleanUp.'
]

{ #category : #cleanup }
MolComponentManager class >> cleanUp: aBoolean [
	"Pharo System CleanUp implementation"
	
	self deepCleanUp.
]

{ #category : #cleanup }
MolComponentManager class >> cleanupMolAnnouncements [
<script>
| registeredList |
registeredList := SystemAnnouncer uniqueInstance subscriptions subscriptions select: [  :e | self isMolAnnoucement: e announcementClass ].
registeredList do: [ :r | SystemAnnouncer uniqueInstance subscriptions remove: r].
]

{ #category : #cleanup }
MolComponentManager class >> deepCleanUp [

	<script: 'self deepCleanUp'>
	| i j |
	"Try to remove non garbaged component instances"
	Smalltalk garbageCollect.
	Smalltalk garbageCollectMost.

	self cleanUp.
	MolUtils log: 'Starting a deep cleanUp.'.
	MolComponentFactory allInstancesDo: [ :factory |
		factory == MolComponentFactory default ifFalse: [ factory release ] ].
	i := self flushComponents.
	j := i.

	"Try to reflush"
	i > 0 ifTrue: [
		
		Smalltalk garbageCollect.
		Smalltalk garbageCollectMost.
		
		(Delay forMilliseconds: 500) wait.
		j := self flushComponents ].

	MolUtils log: 'Deep Cleanup: ' , i printString
		, ' lost component(s) found and released.'.
	i <= 0
		ifFalse: [
			j <= 0
				ifFalse: [
					MolUtils showInformation:
						'Warning : Cannot release ' , i printString
						,
						' component(s) after two clean pass, please try again to confirm correct cleanup.' ]
				ifTrue: [
					MolUtils showInformation: 'Clean success : ' , i printString
						, ' lost component(s) found and released.' ] ]
		ifTrue: [ MolUtils showInformation: 'No problem : image was clean.' ].

	MolUtils log: 'End of the deep cleanUp.'
]

{ #category : #singleton }
MolComponentManager class >> default [
	<script: 'self default inspect'>
	
	Default ifNil: [
		MolComponentFactory isInitialized ifFalse:[MolComponentFactory initialize].
		Default := self new.
	].
	^Default
]

{ #category : #'initialize-release' }
MolComponentManager class >> flushComponents [
	"Flush all components : detect all component class instances of the Pharo image and disconnect each component connector, return number of flushed components"

	| i |
	i := 0.
	"First : search direct component class subinstances (inheritance from MolAbstractComponentImpl class)"
	MolAbstractComponentImpl allSubInstancesDo: [ :component |
		component componentConnector: nil.
		i := i + 1 ].
	"Second : search augmented class component instances (using the MolComponentImpl trait)"
	MolComponentImpl users do: [ :impl |
		impl allInstances do: [ :component |
			component componentConnector: nil.
			i := i + 1 ] ].

	SmalltalkImage cleanUp.
	Smalltalk garbageCollect.
	Smalltalk garbageCollectMost.

	^ i
]

{ #category : #'initialize-release' }
MolComponentManager class >> isInitialized [
	"Test if the Component Manager is initialized"

	<script: 'self isInitialized inspect'>
	^ Default notNil
]

{ #category : #cleanup }
MolComponentManager class >> isMolAnnoucement: aClass [

	MolAnnouncement withAllSubclasses do: [ :a |
		a = aClass ifTrue: [ ^ true ] ].
	^ false
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

	self class cleanUp
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
	homeServices := MolHomeServices new
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
	super release
]
