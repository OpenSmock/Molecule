"
A MolUtilsTest is a test class for testing the behavior of MolUtils
"
Class {
	#name : #MolUtilsTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests'
}

{ #category : #tests }
MolUtilsTest >> testCreateAllComponents [
"MolUtils>createAllComponents instanciate and activate all deployed components"

	| manager |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl2.
	MolUtils createAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl) not.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2) not.
	manager homeServices removeAllComponents.
	manager cleanUp.
]

{ #category : #tests }
MolUtilsTest >> testInstanceKindOf [
"Test method instanceKindOf: of Utils"

	| homeServices |
	MolComponentManager cleanUp.
	MolComponentManager default deploymentServices deployComponentImplementation: MolBasicSubSubComponentImpl.
	homeServices := MolComponentManager default homeServices.
	homeServices instanciateComponent: MolBasicSubSubComponentImpl.
	self assert: (MolUtils instanceKindOf: MolBasicSubComponentImpl) notNil.
	homeServices removeComponent: MolBasicSubSubComponentImpl.
]

{ #category : #tests }
MolUtilsTest >> testInstanceOf [

	| instance |
	MolComponentManager cleanUp.
	MolUtils startComponent: MolBasicSubComponentImpl.
	instance := MolUtils instanceOf: MolBasicSubComponentImpl.
	self assert: instance class equals: MolBasicSubComponentImpl.
	MolComponentManager cleanUp.
	
]

{ #category : #tests }
MolUtilsTest >> testLog [

	| activate |
	MolUtils toggleLog.
	activate := MolUtils isLogActive.
	MolUtils log: self printString.
	MolUtils toggleLog.
	MolUtils log: self printString.
	self assert: MolUtils isLogActive equals: activate not.
]

{ #category : #tests }
MolUtilsTest >> testStartComponent [
"test method startComponent: of Utils"

	| homeServices |
	MolComponentManager cleanUp.
	homeServices := MolComponentManager default homeServices.
	MolUtils startComponent: MolBasicSubComponentImpl.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl) not.
	homeServices removeComponent: MolBasicSubComponentImpl.
]

{ #category : #tests }
MolUtilsTest >> testStartComponentWithName [
"test method startComponent:named: of Utils"

	| homeServices |
	MolComponentManager cleanUp.
	homeServices := MolComponentManager default homeServices.
	MolUtils startComponent: MolBasicSubComponentImpl named: #start.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #start).
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #start) not.
	homeServices removeComponent: MolBasicSubComponentImpl named: #start.
]
