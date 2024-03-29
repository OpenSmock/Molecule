"
A MolDeploymentServicesTest is a test class for testing the behavior of MolDeploymentServices
"
Class {
	#name : #MolDeploymentServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolDeploymentServicesTest >> setUp [ 
	
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolDeploymentServicesTest >> tearDown [  
	
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolDeploymentServicesTest >> testDeployAlreadyDeployedImplementation [
	| manager |
	
	manager := MolComponentManager default.	
	self assert: manager homeServices deployedComponents isEmpty.
	
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl.
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl.

	self assert: manager homeServices deployedComponents size equals: 1.	
	
	manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl.
	self assert: manager homeServices deployedComponents size equals: 0.	
]

{ #category : #tests }
MolDeploymentServicesTest >> testDeployComponentImplementation [
	| manager isError |
	
	manager := MolComponentManager default.	
		
	isError := false.
	[manager deploymentServices deployComponentImplementation: nil] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
	
	isError := false.
	[manager deploymentServices deployComponentImplementation: String] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	

	isError := false.
	[manager deploymentServices deployComponentImplementation: MolBasicComponentImpl new] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
		
	isError := false.
	[manager deploymentServices deployComponentImplementation: MolAugmentedClassToAComponentWithoutType] on: NotATypedComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
		
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl.
	
]

{ #category : #tests }
MolDeploymentServicesTest >> testDeploymentServices [
	| manager |
	
	manager := MolComponentManager default.
	
	self assert: manager homeServices deployedComponents isEmpty.
	
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl.
	self assert: manager homeServices deployedComponents size equals: 1.
	
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl2.
	self assert: manager homeServices deployedComponents size equals: 2.
	
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl2.
	self assert: manager homeServices deployedComponents size equals: 2.
	
	manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl2.
	manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl2.
	self assert: manager homeServices deployedComponents isEmpty.
	
]

{ #category : #tests }
MolDeploymentServicesTest >> testIsDeployedComponentImplementation [
	| manager isError |
	
	manager := MolComponentManager default.	
		
	isError := false.
	[manager deploymentServices isDeployedComponentImplementation: nil] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
	
	isError := false.
	[manager deploymentServices isDeployedComponentImplementation: String] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
		
	isError := false.
	[manager deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl new] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
		
	isError := false.
	[manager deploymentServices isDeployedComponentImplementation: MolAugmentedClassToAComponentWithoutType] on: NotATypedComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
	
	self assert: (manager deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl) equals: false.
	
]

{ #category : #tests }
MolDeploymentServicesTest >> testUndeployANotDeployComponent [
	| manager |
	
	manager := MolComponentManager default.
	
	manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl. "No error"
	
]

{ #category : #tests }
MolDeploymentServicesTest >> testUndeployComponentImplementation [
	| manager isError |
	
	manager := MolComponentManager default.	
		
	isError := false.
	[manager deploymentServices undeployComponentImplementation: nil] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
	
	isError := false.
	[manager deploymentServices undeployComponentImplementation: String] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	

	isError := false.
	[manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl new] on: NotAComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
		
	isError := false.
	[manager deploymentServices undeployComponentImplementation: MolAugmentedClassToAComponentWithoutType] on: NotATypedComponentClassError do:[ :e | isError := true ].
	self assert: isError equals: true.	
	
	manager deploymentServices undeployComponentImplementation: MolBasicComponentImpl.
]
