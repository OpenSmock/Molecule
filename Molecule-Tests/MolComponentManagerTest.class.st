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
