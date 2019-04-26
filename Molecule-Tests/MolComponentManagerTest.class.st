"
A MolComponentManagerTest is a test class for testing the behavior of MolComponentManager
"
Class {
	#name : #MolComponentManagerTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolComponentManagerTest >> testCleanUp [
	| manager1 manager2 |
	MolComponentManager cleanUp.
	
	manager1 := MolComponentManager default.
	manager1 cleanUp.
	
	manager2 := MolComponentManager default.
	manager2 cleanUp.
	
	self assert: manager1 ~= manager2.
	
]

{ #category : #tests }
MolComponentManagerTest >> testComponentManager [
	"Test creation of ComponentManager"
	| manager |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.
	self assert: manager deploymentServices notNil.
	self assert: manager homeServices notNil.
	self assert: manager locatorServices notNil.
	manager cleanUp.
	
]

{ #category : #tests }
MolComponentManagerTest >> testDeepCleanUp [
	MolComponentManager deepCleanUp
]
