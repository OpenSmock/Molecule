"
A MolUtilsTest is a test class for testing the behavior of MolUtils
"
Class {
	#name : #MolUtilsTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolUtilsTest >> setUp [

	MolComponentManager cleanUp
]

{ #category : #tests }
MolUtilsTest >> tearDown [

	MolComponentManager cleanUp
]

{ #category : #tests }
MolUtilsTest >> testAllComponentInstancesOfType [

	self assert: (MolUtils allComponentInstancesOfType: MolCompleteComponent) isEmpty.

	MolUtils startComponent: MolCompleteComponentImpl named: #compA.
	MolUtils startComponent: MolCompleteComponentImpl named: #compB.
	MolUtils startComponent: MolCompleteComponentImpl named: #compC.
	
	self assert: (MolUtils allComponentInstancesOfType: MolCompleteComponent) size = 3.
	
	MolUtils startComponent: MolCompleteComponentImpl named: #compD.
	
	self assert: (MolUtils allComponentInstancesOfType: MolCompleteComponent) size = 4.
	
	
]

{ #category : #tests }
MolUtilsTest >> testCreateAllComponents [
"MolUtils>createAllComponents instanciate and activate all deployed components"

	| manager |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	MolUtils createAllComponents.
	
	self assert: (MolUtils isInstanciateComponentOf: MolBasicComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolCompleteComponentImpl).
	self assert: (manager homeServices isWaitingForActivation: MolBasicComponentImpl) not.
	self assert: (manager homeServices isWaitingForActivation: MolCompleteComponentImpl) not.
	

]

{ #category : #tests }
MolUtilsTest >> testInstanceKindOf [
"Test method instanceKindOf: of Utils"

	| homeServices |
	MolComponentManager default deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	homeServices := MolComponentManager default homeServices.
	homeServices instanciateComponent: MolBasicSubComponentImpl.
	self assert: (MolUtils instanceKindOf: MolBasicComponentImpl) notNil.
]

{ #category : #tests }
MolUtilsTest >> testInstanceOf [

	| instance |
	MolUtils startComponent: MolBasicComponentImpl.
	instance := MolUtils instanceOf: MolBasicComponentImpl.
	self assert: instance class equals: MolBasicComponentImpl.
	
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
MolUtilsTest >> testLog2 [

	| activate |
	activate := MolUtils isLogActive.
	MolUtils  isLogActive: (activate not).
	self assert: MolUtils isLogActive equals: activate not.
	MolUtils  isLogActive: (MolUtils  isLogActive not).
	self assert: MolUtils isLogActive equals: activate.
	MolUtils  isLogActive: (activate).
]

{ #category : #tests }
MolUtilsTest >> testShowInformation [
	MolUtils showInformation: nil.
	MolUtils showInformation: #test.
	MolUtils showInformation: MolCompleteComponent.
	MolUtils showInformation: Time now.
	MolUtils showInformation: 'My Information Message'.
]

{ #category : #tests }
MolUtilsTest >> testStartComponent [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl.

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicComponentImpl).
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStartComponentWithName [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl named: #myComponent.
	
	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicComponentImpl named: #myComponent).
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl named: #myComponent) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStartComponents [

	| homeServices deploymentServices componentList |
	componentList := OrderedCollection with: MolBasicComponentImpl with: MolCompleteComponentImpl.
	MolUtils startComponents: componentList.

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl).
	self assert: (deploymentServices isDeployedComponentImplementation: MolCompleteComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolCompleteComponentImpl).
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl) equals: false.
	self assert: (homeServices isWaitingForActivation: MolCompleteComponentImpl) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStopComponent [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl.
	MolUtils stopComponent: MolBasicComponentImpl.	

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 	
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl) equals: true.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicComponentImpl) equals: false.
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStopComponentWithName [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl named: #myComponent.
	MolUtils stopComponent: MolBasicComponentImpl named: #myComponent.
	
	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl) equals: true.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicComponentImpl named: #myComponent) equals: false.
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl named: #myComponent) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStopComponents [

	| homeServices deploymentServices componentList |
	MolUtils startComponent: MolBasicComponentImpl; startComponent: MolCompleteComponentImpl.
	componentList := OrderedCollection with: MolBasicComponentImpl with: MolCompleteComponentImpl.
	MolUtils stopComponents: componentList.	

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 	
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicComponentImpl) equals: true.
	self assert: (deploymentServices isDeployedComponentImplementation: MolCompleteComponentImpl) equals: true.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicComponentImpl) equals: false.
	self assert: (MolUtils isInstanciateComponentOf: MolCompleteComponentImpl) equals: false.
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl) equals: false.
self assert: (homeServices isWaitingForActivation: MolCompleteComponentImpl) equals: false.
]
