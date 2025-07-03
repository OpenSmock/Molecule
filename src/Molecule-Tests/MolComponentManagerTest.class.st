"
A MolComponentManagerTest is a test class for testing the behavior of MolComponentManager
"
Class {
	#name : #MolComponentManagerTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #'setUp - tearDown' }
MolComponentManagerTest >> setUp [

	super setUp.
	MolComponentManager cleanUp.
	Smalltalk garbageCollect.
	Smalltalk garbageCollectMost.
]

{ #category : #'setUp - tearDown' }
MolComponentManagerTest >> tearDown [

	MolComponentManager cleanUp.
	Smalltalk garbageCollect.
	Smalltalk garbageCollectMost.
	super tearDown
]

{ #category : #tests }
MolComponentManagerTest >> testCleanUp [
	| manager1 manager2 |
	manager1 := MolComponentManager default.
	manager1 cleanUp.
	
	manager2 := MolComponentManager default.
	manager2 cleanUp.
	
	self assert: manager1 ~= manager2.
	
]

{ #category : #tests }
MolComponentManagerTest >> testCleanUpAnnouncements [
| announcement list selection |
announcement := nil.
	SystemAnnouncer uniqueInstance when: MolComponentInstantiated do:[ :a | announcement := a ] for: self.
	SystemAnnouncer uniqueInstance when: MolComponentPassivated do:[ :a | announcement := a ] for: self.
	SystemAnnouncer uniqueInstance when: MolComponentInstantiated do:[ :a | announcement := a ] for: self.
	list := MolAnnouncement withAllSubclasses.
	selection := SystemAnnouncer uniqueInstance subscriptions subscriptions select: [  :e | list includes: e announcementClass] .
	self assert: (selection size > 0).
	MolComponentManager cleanupMolAnnouncements.
	selection := SystemAnnouncer uniqueInstance subscriptions subscriptions select: [  :e | list includes: e announcementClass] .
	self assert: (selection size = 0).
	
]

{ #category : #'tests - general' }
MolComponentManagerTest >> testCleanUpIgnoreErrors [
	"Start a manuel tree of components and clean up, components are removed during the cleanUp but some componentRemove methods should remove again an already removed component : a error is reach but ignored during a cleanUp"
	
	"Check no error"
	MolUtils startComponent: MolTestComponentTreeLevel0Impl.	
]

{ #category : #'tests - component start & stop' }
MolComponentManagerTest >> testComponentTree [
	"Start a component Tree : a component which is starting sub components, etc."

	| nb |
	MolComponentManager default deploymentServices
		deployComponentImplementation: MolTestComponentTreeLevel0Impl.
	MolComponentManager default homeServices instantiateComponent:
		MolTestComponentTreeLevel0Impl.
	MolComponentManager default homeServices activateComponent:
		MolTestComponentTreeLevel0Impl.

	"Check started components"
	nb := 0.
	MolComponentManager default homeServices deployedComponents
		valuesDo: [ :compList | nb := nb + compList size ].
	self assert: nb equals: 13.

	MolComponentManager default homeServices passivateComponent:
		MolTestComponentTreeLevel0Impl.
	MolComponentManager default homeServices removeComponent:
		MolTestComponentTreeLevel0Impl.
	MolComponentManager default deploymentServices
		undeployComponentImplementation: MolTestComponentTreeLevel2Impl
]

{ #category : #tests }
MolComponentManagerTest >> testDeepCleanUp [

	| manager factory |
	manager := MolComponentManager default.	
	factory := MolComponentFactory default.
	MolComponentManager deepCleanUp.
	
	self assert: manager deploymentServices isNil.
	self assert: manager homeServices isNil.
	self assert: manager locatorServices isNil.
	self assert: factory == MolComponentFactory default equals: false.
]

{ #category : #tests }
MolComponentManagerTest >> testDefault [
	self assert: (MolComponentManager default isKindOf: MolComponentManager).
	
]

{ #category : #tests }
MolComponentManagerTest >> testDeploymentServices [
	| manager |
	manager := MolComponentManager default.
	self assert: (manager deploymentServices isKindOf: MolDeploymentServices).
]

{ #category : #tests }
MolComponentManagerTest >> testHomeServices [
	| manager |
	manager := MolComponentManager default.
	self assert: (manager homeServices isKindOf: MolHomeServices).
]

{ #category : #tests }
MolComponentManagerTest >> testImageCleanUp [
	"Test the Do Image Cleanup Pharo function"
	
	| manager factory |
	manager := MolComponentManager default.	
	factory := MolComponentFactory default.
	MolComponentManager cleanUp: true.
	
	self assert: manager deploymentServices isNil.
	self assert: manager homeServices isNil.
	self assert: manager locatorServices isNil.
	self assert: factory == MolComponentFactory default equals: false.
	
]

{ #category : #tests }
MolComponentManagerTest >> testInitialize [
	| manager |
	self assert: MolComponentManager isInitialized equals: false.
	manager := MolComponentManager default.
	self assert: MolComponentManager isInitialized equals: true.
	self assert: manager deploymentServices notNil.
	self assert: manager locatorServices notNil.
	self assert: manager homeServices notNil.
]

{ #category : #tests }
MolComponentManagerTest >> testIsInitialized [
	self assert: MolComponentManager isInitialized equals: false.
	MolComponentManager default.
	self assert: MolComponentManager isInitialized equals: true.
	MolComponentManager cleanUp.
	self assert: MolComponentManager isInitialized equals: false.
]

{ #category : #tests }
MolComponentManagerTest >> testIsRunningComponents [

	self assert: MolComponentManager isRunningComponents equals: false.
	
	MolUtils startComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.
	
	MolUtils stopComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: false.
]

{ #category : #'tests - general' }
MolComponentManagerTest >> testIsRunningComponentsAllSteps [

	MolComponentManager default deploymentServices
		deployComponentImplementation: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: false.

	MolComponentManager default homeServices instantiateComponent:
		MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.

	MolComponentManager default homeServices activateComponent:
		MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.

	MolComponentManager default homeServices passivateComponent:
		MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.

	MolComponentManager default homeServices removeComponent:
		MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: false
]

{ #category : #tests }
MolComponentManagerTest >> testLocatorServices [
	| manager |
	manager := MolComponentManager default.
	self assert: (manager locatorServices isKindOf: MolLocatorServices).
]

{ #category : #tests }
MolComponentManagerTest >> testRelease [
	| manager |
	manager := MolComponentManager default.
	self assert: MolComponentManager isInitialized equals: true.
	MolComponentManager cleanUp.
	self assert: MolComponentManager isInitialized equals: false.
	self assert: manager deploymentServices isNil.
	self assert: manager locatorServices isNil.
	self assert: manager homeServices isNil.
]
