"
A MolComponentManagerTest is a test class for testing the behavior of MolComponentManager
"
Class {
	#name : #MolComponentManagerTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests'
}

{ #category : #tests }
MolComponentManagerTest >> testComponentManager [
"Test creation of ComponentManager"

	| manager |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.
	self assert: manager deploymentServices notNil.
	self assert: manager homeServices notNil.
	self assert: manager locatorServices notNil.
	manager cleanUp
]

{ #category : #tests }
MolComponentManagerTest >> testDeepCleanUp [
"Test execution of the method"

	MolComponentManager deepCleanUp
]
