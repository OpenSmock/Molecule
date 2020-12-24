"
A MolComponentManagerTest is a test class for testing the behavior of MolComponentManager
"
Class {
	#name : #MolComponentManagerTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #'tests - general' }
MolComponentManagerTest >> testCleanUp [
	| manager1 manager2 |
	MolComponentManager cleanUp.
	
	manager1 := MolComponentManager default.
	manager1 cleanUp.
	
	manager2 := MolComponentManager default.
	manager2 cleanUp.
	
	self assert: manager1 ~= manager2.
	
]

{ #category : #'tests - general' }
MolComponentManagerTest >> testCleanUpIgnoreErrors [
	"Start a manuel tree of components and clean up, components are removed during the cleanUp but some componentRemove methods should remove again an already removed component : a error is reach but ignored during a cleanUp"
	
	MolComponentManager cleanUp.

	"Check no error"
	MolUtils startComponent: MolTestComponentTreeLevel0Impl.	
	
	MolComponentManager cleanUp.
]

{ #category : #'tests - general' }
MolComponentManagerTest >> testComponentManager [
	"Test creation of ComponentManager"
	| manager factory |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.
	factory := MolComponentFactory default.
	self assert: manager deploymentServices notNil.
	self assert: manager homeServices notNil.
	self assert: manager locatorServices notNil.
	
	manager cleanUp.
	self assert: manager deploymentServices isNil.
	self assert: manager homeServices isNil.
	self assert: manager locatorServices isNil.
	self assert: factory == MolComponentFactory default equals: false.
]

{ #category : #'tests - component start & stop' }
MolComponentManagerTest >> testComponentTree [
	"Start a component Tree : a component which is starting sub components, etc."
	| nb |
	MolComponentManager cleanUp.
	MolComponentManager default deploymentServices deployComponentImplementation: MolTestComponentTreeLevel0Impl.
	MolComponentManager default homeServices instanciateComponent: MolTestComponentTreeLevel0Impl.
	MolComponentManager default homeServices activateComponent: MolTestComponentTreeLevel0Impl.
	
	"Check started components"
	nb := 0.
	MolComponentManager default homeServices deployedComponents valuesDo:[ :compList | nb := nb + (compList size) ].
	self assert: nb equals: 13.
	
	MolComponentManager default homeServices passivateComponent: MolTestComponentTreeLevel0Impl.
	MolComponentManager default homeServices removeComponent: MolTestComponentTreeLevel0Impl.
	MolComponentManager default deploymentServices undeployComponentImplementation: MolTestComponentTreeLevel2Impl.
	MolComponentManager cleanUp.
]

{ #category : #'tests - general' }
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

{ #category : #'tests - general' }
MolComponentManagerTest >> testIsRunningComponents [

	MolComponentManager cleanUp.
	self assert: MolComponentManager isRunningComponents equals: false.
	
	MolUtils startComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.
	
	MolUtils stopComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: false.
	MolComponentManager cleanUp.
]

{ #category : #'tests - general' }
MolComponentManagerTest >> testIsRunningComponentsAllSteps [

	MolComponentManager cleanUp.
	MolComponentManager default deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: false.
	
	MolComponentManager default homeServices instanciateComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.
	
	MolComponentManager default homeServices activateComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.
	
	MolComponentManager default homeServices passivateComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: true.

	MolComponentManager default homeServices removeComponent: MolCompleteComponentImpl.
	self assert: MolComponentManager isRunningComponents equals: false.
	
	MolComponentManager cleanUp.
]
