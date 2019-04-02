"
A MolDeploymentServicesTest is a test class for testing the behavior of MolDeploymentServices
"
Class {
	#name : #MolDeploymentServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests'
}

{ #category : #tests }
MolDeploymentServicesTest >> testDeploymentServices [
"Test creation of ComponentManager"

	| manager |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.
	self assert: manager homeServices deployedComponents isEmpty.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	self assert: manager homeServices deployedComponents size equals: 1.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl2.
	self assert: manager homeServices deployedComponents size equals: 2.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl2.
	self assert: manager homeServices deployedComponents size equals: 2.
	manager deploymentServices undeployComponentImplementation: MolBasicSubComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolBasicSubComponentImpl2.
	manager deploymentServices undeployComponentImplementation: MolBasicSubComponentImpl2.
	self assert: manager homeServices deployedComponents isEmpty.
	manager cleanUp
]
