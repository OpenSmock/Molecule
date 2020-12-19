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
MolUtilsTest >> testCreateAllComponents [
"MolUtils>createAllComponents instanciate and activate all deployed components"

	| manager |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl2.
	MolUtils createAllComponents.
	
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl) not.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2) not.
	

]

{ #category : #tests }
MolUtilsTest >> testDefineAllComponents [

	MolUtils defineAllComponents.
]

{ #category : #tests }
MolUtilsTest >> testInstanceKindOf [
"Test method instanceKindOf: of Utils"

	| homeServices |
	MolComponentManager default deploymentServices deployComponentImplementation: MolBasicSubSubComponentImpl.
	homeServices := MolComponentManager default homeServices.
	homeServices instanciateComponent: MolBasicSubSubComponentImpl.
	self assert: (MolUtils instanceKindOf: MolBasicSubComponentImpl) notNil.
]

{ #category : #tests }
MolUtilsTest >> testInstanceOf [

	| instance |
	MolUtils startComponent: MolBasicSubComponentImpl.
	instance := MolUtils instanceOf: MolBasicSubComponentImpl.
	self assert: instance class equals: MolBasicSubComponentImpl.
	
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
	MolUtils startComponent: MolBasicSubComponentImpl.

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStartComponentWithName [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicSubComponentImpl named: #myComponent.
	
	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #myComponent).
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #myComponent) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStartComponents [

	| homeServices deploymentServices componentList |
	componentList := OrderedCollection with: MolBasicSubComponentImpl with: MolCompleteComponentImpl.
	MolUtils startComponents: componentList.

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicSubComponentImpl).
	self assert: (deploymentServices isDeployedComponentImplementation: MolCompleteComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolCompleteComponentImpl).
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl) equals: false.
	self assert: (homeServices isWaitingForActivation: MolCompleteComponentImpl) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStopComponent [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicSubComponentImpl.
	MolUtils stopComponent: MolBasicSubComponentImpl.	

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 	
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicSubComponentImpl) equals: false.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl) equals: false.
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStopComponentWithName [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicSubComponentImpl named: #myComponent.
	MolUtils stopComponent: MolBasicSubComponentImpl named: #myComponent.
	
	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicSubComponentImpl) equals: false.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #myComponent) equals: false.
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #myComponent) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testStopComponents [

	| homeServices deploymentServices componentList |
	MolUtils startComponent: MolBasicSubComponentImpl; startComponent: MolCompleteComponentImpl.
	componentList := OrderedCollection with: MolBasicSubComponentImpl with: MolCompleteComponentImpl.
	MolUtils stopComponents: componentList.	

	homeServices := MolComponentManager default homeServices.	
	deploymentServices := MolComponentManager default deploymentServices. 	
	self assert: (deploymentServices isDeployedComponentImplementation: MolBasicSubComponentImpl) equals: false.
	self assert: (deploymentServices isDeployedComponentImplementation: MolCompleteComponentImpl) equals: false.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl) equals: false.
	self assert: (MolUtils isInstanciateComponentOf: MolCompleteComponentImpl) equals: false.
	self assert: (homeServices isWaitingForActivation: MolBasicSubComponentImpl) equals: false.
self assert: (homeServices isWaitingForActivation: MolCompleteComponentImpl) equals: false.
]
