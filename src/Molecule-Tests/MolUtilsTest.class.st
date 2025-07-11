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
MolUtilsTest >> testActivateComponentNamed [

	| homeServices deploymentServices |
	MolUtils
		deployAndInitializeComponent: MolBasicComponentImpl
		named: #myComponent.
	MolUtils activateComponent: MolBasicComponentImpl named: #myComponent.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #myComponent).
	self
		assert: (homeServices
				 isWaitingForActivation: MolBasicComponentImpl
				 named: #myComponent)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testActivateComponents [

	| homeServices componentList |
	componentList := OrderedCollection with: MolBasicComponentImpl with: MolCompleteComponentImpl.
	MolUtils deployAndInitializeComponents: componentList.
	MolUtils activateComponents: componentList.

	homeServices := MolComponentManager default homeServices.	
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl) equals: false.
	self assert: (homeServices isWaitingForActivation: MolCompleteComponentImpl) equals: false.
]

{ #category : #tests }
MolUtilsTest >> testAllComponentImplementationClassesOfType [

	self assert: (MolUtils allComponentImplementationClassesOfType: MolCompleteComponent) size equals: 6.
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
MolUtilsTest >> testAllComponentInstancesOfType2 [

	self assert: (MolUtils allComponentInstancesOfType: MolCompleteComponent) isEmpty.

	MolUtils startComponent: MolCompleteComponentChild2Impl named: #compA.
	MolUtils startComponent: MolCompleteComponentChild2Impl named: #compB.
	MolUtils startComponent: MolCompleteComponentChild2Impl named: #compC.
	
	self assert: (MolUtils allComponentInstancesOfType: MolCompleteComponent) size = 3.
	
	MolUtils startComponent: MolCompleteComponentChild2Impl named: #compD.
	
	self assert: (MolUtils allComponentInstancesOfType: MolCompleteComponent) size = 4.
	
	
]

{ #category : #tests }
MolUtilsTest >> testComponentType [

	self assert: (MolUtils componentType: nil) isNil.
	self assert: (MolUtils componentType: 45) isNil.
	self assert: (MolUtils componentType: Integer) isNil.
	self assert: (MolUtils componentType: MolComponentImpl) isNil.
	self assert: (MolUtils componentType: MolCompleteComponentImpl) equals: MolCompleteComponent.
	self assert: (MolUtils componentType: MolCompleteComponentImpl new) equals: MolCompleteComponent.
	self assert: (MolUtils componentType: MolCompleteComponent) isNil.
]

{ #category : #tests }
MolUtilsTest >> testConsumedComponentEvents [

	"potential bugs"
	self assert: (MolUtils consumedComponentEvents: nil) isEmpty.
	self assert: (MolUtils consumedComponentEvents: 45) isEmpty.
	self assert: (MolUtils consumedComponentEvents: Integer) isEmpty.
	self assert: (MolUtils consumedComponentEvents: MolDirtyType) isEmpty.
	
	"concrete cases"
	self assert:
		(MolUtils consumedComponentEvents: MolComponentImpl) isEmpty.
	self assert:
		(MolUtils consumedComponentEvents: MolCompleteComponentImpl)
			notEmpty.
	self
		assert:
			(MolUtils consumedComponentEvents: MolCompleteComponentOverloadImpl)
				size
		equals: 2.		
	self
		assert:
		(MolUtils consumedComponentEvents: MolCompleteComponentImpl) first
		equals: MolUsedEvents.
	self assert:
		(MolUtils consumedComponentEvents: MolCompleteComponentImpl new)
			notEmpty.
	self
		assert:
		(MolUtils consumedComponentEvents: MolCompleteComponentImpl new)
			first
		equals: MolUsedEvents.
	self assert:
		(MolUtils consumedComponentEvents: MolCompleteComponent) notEmpty.
	self
		assert:
		(MolUtils consumedComponentEvents: MolCompleteComponent) first
		equals: MolUsedEvents.

	self assert:
		(MolUtils consumedComponentEvents: MolComponentServices) isEmpty.
	self assert:
		(MolUtils consumedComponentEvents: MolComponentParameters) isEmpty.
	self assert:
		(MolUtils consumedComponentEvents: MolComponentEvents) isEmpty
]

{ #category : #tests }
MolUtilsTest >> testCreateAllComponents [
	"MolUtils>createAllComponents instanciate and activate all deployed components"

	| manager |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation:
		MolBasicComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolCompleteComponentImpl.
	MolUtils createAllComponents.

	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl).
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl)
			not.
	self assert:
		(manager homeServices isWaitingForActivation:
			 MolCompleteComponentImpl) not
]

{ #category : #tests }
MolUtilsTest >> testDeployAndInitializeComponentNamed [

	| homeServices deploymentServices |
	MolUtils
		deployAndInitializeComponent: MolBasicComponentImpl
		named: #myComponent.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #myComponent).
	self
		assert: (homeServices
				 isWaitingForActivation: MolBasicComponentImpl
				 named: #myComponent)
		equals: true
]

{ #category : #tests }
MolUtilsTest >> testDeployAndInitializeComponents [

	| homeServices deploymentServices componentList |
	componentList := OrderedCollection
		                 with: MolBasicComponentImpl
		                 with: MolCompleteComponentImpl.
	MolUtils deployAndInitializeComponents: componentList.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolCompleteComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl).
	self
		assert: (homeServices isWaitingForActivation: MolBasicComponentImpl)
		equals: true.
	self
		assert:
		(homeServices isWaitingForActivation: MolCompleteComponentImpl)
		equals: true
]

{ #category : #tests }
MolUtilsTest >> testInstanceKindOf [
	"Test method instanceKindOf: of Utils"

	| homeServices |
	MolComponentManager default deploymentServices
		deployComponentImplementation: MolBasicSubComponentImpl.
	homeServices := MolComponentManager default homeServices.
	homeServices instantiateComponent: MolBasicSubComponentImpl.
	self assert: (MolUtils instanceKindOf: MolBasicComponentImpl) notNil
]

{ #category : #tests }
MolUtilsTest >> testInstanceOf [

	| instance |
	MolUtils startComponent: MolBasicComponentImpl.
	instance := MolUtils instanceOf: MolBasicComponentImpl.
	self assert: instance class equals: MolBasicComponentImpl.
	
]

{ #category : #tests }
MolUtilsTest >> testIsComponentOrComponentClass [

	self assert: (MolUtils isComponentOrComponentClass: nil) equals: false.
	self assert: (MolUtils isComponentOrComponentClass: 45) equals: false.
	self assert: (MolUtils isComponentOrComponentClass: Integer) equals: false. 
	self assert: (MolUtils isComponentOrComponentClass: MolComponentImpl) equals: false.
	self assert: (MolUtils isComponentOrComponentClass: MolCompleteComponentImpl) equals: true.
	self assert: (MolUtils isComponentOrComponentClass: MolCompleteComponentImpl new) equals: true.
	self assert: (MolUtils isComponentOrComponentClass: MolCompleteComponent) equals: false.
	self assert: (MolUtils isComponentOrComponentClass: MolComponentServices) equals: false.
	self assert: (MolUtils isComponentOrComponentClass: MolComponentParameters) equals: false.
	self assert: (MolUtils isComponentOrComponentClass: MolComponentEvents) equals: false.
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
MolUtilsTest >> testOfferedTypes [

	"Not used services"
	| types |
	self assert: (MolUtils offeredTypes: nil) isEmpty. "test with nil"
	self assert: (MolUtils offeredTypes: Trait) isEmpty. "test with no component interface object"
	self assert: (MolUtils offeredTypes: MolUnusedServices) isEmpty. "test with unused interface"
	
	"Type used services"
	types := MolUtils offeredTypes: MolUsedServices.
	self assert: types size equals: 3.
	self assert: (types includes: MolCompleteComponent).
	self assert: (types includes: MolCompleteComponent2).
	self assert: (types includes: MolCompleteComponentTypeUser).
	
	"Type provide events"
	types := MolUtils offeredTypes: MolUsedEvents.
	self assert: types size equals: 3.
	self assert: (types includes: MolCompleteComponent).
	self assert: (types includes: MolCompleteComponent2).
	self assert: (types includes: MolCompleteComponentTypeUser).
	
	"Type used parameters"
	types := MolUtils offeredTypes: MolUsedParameters.
	self assert: types size equals: 3.
	self assert: (types includes: MolCompleteComponent).
	self assert: (types includes: MolCompleteComponent2).
	self assert: (types includes: MolCompleteComponentTypeUser).
]

{ #category : #tests }
MolUtilsTest >> testPassivateComponentNamed [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl named: #myComponent.
	MolUtils
		passivateComponent: MolBasicComponentImpl
		named: #myComponent.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self
		assert: (MolUtils
				 isInstantiateComponentOf: MolBasicComponentImpl
				 named: #myComponent)
		equals: true.
	self
		assert: (homeServices
				 isWaitingForActivation: MolBasicComponentImpl
				 named: #myComponent)
		equals: true
]

{ #category : #tests }
MolUtilsTest >> testPassivateComponents [

	| homeServices componentList |
	componentList := OrderedCollection with: MolBasicComponentImpl with: MolCompleteComponentImpl.
	MolUtils startComponents: componentList.
	MolUtils passivateComponents: componentList.

	homeServices := MolComponentManager default homeServices.	
	self assert: (homeServices isWaitingForActivation: MolBasicComponentImpl) equals: true.
	self assert: (homeServices isWaitingForActivation: MolCompleteComponentImpl) equals: true.
]

{ #category : #tests }
MolUtilsTest >> testProducedComponentEvents [

	"potential bugs"
	self assert: (MolUtils producedComponentEvents: nil) isEmpty.
	self assert: (MolUtils producedComponentEvents: 45) isEmpty.
	self assert: (MolUtils producedComponentEvents: Integer) isEmpty.
	self assert: (MolUtils producedComponentEvents: MolDirtyType) isEmpty.
	
	"concrete cases"
	self assert:
		(MolUtils producedComponentEvents: MolComponentImpl) isEmpty.
	self assert:
		(MolUtils producedComponentEvents: MolCompleteComponentImpl)
			notEmpty.
	self
		assert: (MolUtils producedComponentEvents:
				 MolCompleteComponentOverloadImpl) size
		equals: 2.
	self
		assert:
		(MolUtils producedComponentEvents: MolCompleteComponentImpl) first
		equals: MolUsedEvents.
	self assert:
		(MolUtils producedComponentEvents: MolCompleteComponentImpl new)
			notEmpty.
	self
		assert:
		(MolUtils producedComponentEvents: MolCompleteComponentImpl new)
			first
		equals: MolUsedEvents.
	self assert:
		(MolUtils producedComponentEvents: MolCompleteComponent) notEmpty.
	self
		assert:
		(MolUtils producedComponentEvents: MolCompleteComponent) first
		equals: MolUsedEvents.

	self assert:
		(MolUtils producedComponentEvents: MolComponentServices) isEmpty.
	self assert:
		(MolUtils producedComponentEvents: MolComponentParameters) isEmpty.
	self assert:
		(MolUtils producedComponentEvents: MolComponentEvents) isEmpty
]

{ #category : #tests }
MolUtilsTest >> testProvidedComponentParameters [

	"potential bugs"
	self assert: (MolUtils providedComponentParameters: nil) isEmpty.
	self assert: (MolUtils providedComponentParameters: 45) isEmpty.
	self assert: (MolUtils providedComponentParameters: Integer) isEmpty.
	self assert: (MolUtils providedComponentParameters: MolDirtyType) isEmpty.
	
	"concrete cases"
	self assert:
		(MolUtils providedComponentParameters: MolComponentImpl) isEmpty.
	self assert:
		(MolUtils providedComponentParameters: MolCompleteComponentImpl)
			notEmpty.
	self
		assert:
			(MolUtils providedComponentParameters:
				 MolCompleteComponentOverloadImpl) size
		equals: 2.
	self
		assert:
		(MolUtils providedComponentParameters: MolCompleteComponentImpl)
			first
		equals: MolUsedParameters.
	self assert:
		(MolUtils providedComponentParameters: MolCompleteComponentImpl new)
			notEmpty.
	self
		assert:
			(MolUtils providedComponentParameters: MolCompleteComponentImpl new)
				first
		equals: MolUsedParameters.
	self assert:
		(MolUtils providedComponentParameters: MolCompleteComponent)
			notEmpty.
	self
		assert:
		(MolUtils providedComponentParameters: MolCompleteComponent) first
		equals: MolUsedParameters.

	self assert:
		(MolUtils providedComponentParameters: MolComponentServices) isEmpty.
	self assert:
		(MolUtils providedComponentParameters: MolComponentParameters)
			isEmpty.
	self assert:
		(MolUtils providedComponentParameters: MolComponentEvents) isEmpty
]

{ #category : #tests }
MolUtilsTest >> testProvidedComponentServices [

	"potential bugs"
	self assert: (MolUtils providedComponentServices: nil) isEmpty.
	self assert: (MolUtils providedComponentServices: 45) isEmpty.
	self assert: (MolUtils providedComponentServices: Integer) isEmpty.
	self assert: (MolUtils providedComponentServices: MolDirtyType) isEmpty.
	
	"concrete cases"
	self assert:
		(MolUtils providedComponentServices: MolComponentImpl) isEmpty.
	self assert:
		(MolUtils providedComponentServices: MolCompleteComponentImpl)
			notEmpty.
	self
		assert:
			(MolUtils providedComponentServices:
				 MolCompleteComponentOverloadImpl) size
		equals: 2.
	self
		assert:
		(MolUtils providedComponentServices: MolCompleteComponentImpl) first
		equals: MolUsedServices.
	self assert:
		(MolUtils providedComponentServices: MolCompleteComponentImpl new)
			notEmpty.
	self
		assert:
			(MolUtils providedComponentServices: MolCompleteComponentImpl new)
				first
		equals: MolUsedServices.
	self assert:
		(MolUtils providedComponentServices: MolCompleteComponent) notEmpty.
	self
		assert:
		(MolUtils providedComponentServices: MolCompleteComponent) first
		equals: MolUsedServices.

	self assert:
		(MolUtils providedComponentServices: MolComponentServices) isEmpty.
	self assert:
		(MolUtils providedComponentServices: MolComponentParameters) isEmpty.
	self assert:
		(MolUtils providedComponentServices: MolComponentEvents) isEmpty
]

{ #category : #tests }
MolUtilsTest >> testRemoveComponentNamed [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl named: #myComponent.
	MolUtils removeComponent: MolBasicComponentImpl named: #myComponent.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self
		assert: (MolUtils
				 isInstantiateComponentOf: MolBasicComponentImpl
				 named: #myComponent)
		equals: false.
	self
		assert: (homeServices
				 isWaitingForActivation: MolBasicComponentImpl
				 named: #myComponent)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testRemoveComponentNamedIfAbsent [

	| val |
	val := MolUtils
		       removeComponent: MolBasicComponentImpl
		       named: #myComponentUnique
		       ifAbsent: [ #Totoro ].
	self assert: val equals: #Totoro
]

{ #category : #tests }
MolUtilsTest >> testRemoveComponents [

	| homeServices componentList |
	componentList := OrderedCollection
		                 with: MolBasicComponentImpl
		                 with: MolCompleteComponentImpl.
	MolUtils startComponents: componentList.
	MolUtils removeComponents: componentList.

	homeServices := MolComponentManager default homeServices.
	self
		assert: (MolUtils isInstantiateComponentOf: MolBasicComponentImpl)
		equals: false.
	self
		assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl)
		equals: false.
	self
		assert: (homeServices isWaitingForActivation: MolBasicComponentImpl)
		equals: false.
	self
		assert:
		(homeServices isWaitingForActivation: MolCompleteComponentImpl)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testRequiredTypes [

	"Not used services"
	| types |
	self assert: (MolUtils requiredTypes: nil) isEmpty. "test with nil"
	self assert: (MolUtils requiredTypes: Trait) isEmpty. "test with no component interface object"
	self assert: (MolUtils requiredTypes: MolUnusedServices) isEmpty. "test with unused interface"
	
	"Type used services"
	types := MolUtils requiredTypes: MolUsedServices.
	self assert: types size equals: 3.
	self assert: (types includes: MolCompleteComponent).
	self assert: (types includes: MolCompleteComponent2).
	self assert: (types includes: MolCompleteComponentTypeUser).
	
	"Type provide events"
	types := MolUtils requiredTypes: MolUsedEvents.
	self assert: types size equals: 3.
	self assert: (types includes: MolCompleteComponent).
	self assert: (types includes: MolCompleteComponent2).
	self assert: (types includes: MolCompleteComponentTypeUser).
	
	"Type used parameters"
	types := MolUtils requiredTypes: MolUsedParameters.
	self assert: types size equals: 3.
	self assert: (types includes: MolCompleteComponent).
	self assert: (types includes: MolCompleteComponent2).
	self assert: (types includes: MolCompleteComponentTypeUser).
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
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self
		assert: (homeServices isWaitingForActivation: MolBasicComponentImpl)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testStartComponentNamed [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl named: #myComponent.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #myComponent).
	self
		assert: (homeServices
				 isWaitingForActivation: MolBasicComponentImpl
				 named: #myComponent)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testStartComponents [

	| homeServices deploymentServices componentList |
	componentList := OrderedCollection
		                 with: MolBasicComponentImpl
		                 with: MolCompleteComponentImpl.
	MolUtils startComponents: componentList.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolBasicComponentImpl).
	self assert: (deploymentServices isDeployedComponentImplementation:
			 MolCompleteComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl).
	self
		assert: (homeServices isWaitingForActivation: MolBasicComponentImpl)
		equals: false.
	self
		assert:
		(homeServices isWaitingForActivation: MolCompleteComponentImpl)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testStopComponent [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl.
	MolUtils stopComponent: MolBasicComponentImpl.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self
		assert: (deploymentServices isDeployedComponentImplementation:
				 MolBasicComponentImpl)
		equals: true.
	self
		assert: (MolUtils isInstantiateComponentOf: MolBasicComponentImpl)
		equals: false.
	self
		assert: (homeServices isWaitingForActivation: MolBasicComponentImpl)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testStopComponentNamed [

	| homeServices deploymentServices |
	MolUtils startComponent: MolBasicComponentImpl named: #myComponent.
	MolUtils stopComponent: MolBasicComponentImpl named: #myComponent.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self
		assert: (deploymentServices isDeployedComponentImplementation:
				 MolBasicComponentImpl)
		equals: true.
	self
		assert: (MolUtils
				 isInstantiateComponentOf: MolBasicComponentImpl
				 named: #myComponent)
		equals: false.
	self
		assert: (homeServices
				 isWaitingForActivation: MolBasicComponentImpl
				 named: #myComponent)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testStopComponentNamedIfAbsent [

	| homeServices deploymentServices result |
	result := MolUtils stopComponent: MolBasicComponentImpl named: #myComponent ifAbsent: [ #totoro ].
	
	self
		assert: result
		equals: #totoro.

]

{ #category : #tests }
MolUtilsTest >> testStopComponents [

	| homeServices deploymentServices componentList |
	MolUtils
		startComponent: MolBasicComponentImpl;
		startComponent: MolCompleteComponentImpl.
	componentList := OrderedCollection
		                 with: MolBasicComponentImpl
		                 with: MolCompleteComponentImpl.
	MolUtils stopComponents: componentList.

	homeServices := MolComponentManager default homeServices.
	deploymentServices := MolComponentManager default deploymentServices.
	self
		assert: (deploymentServices isDeployedComponentImplementation:
				 MolBasicComponentImpl)
		equals: true.
	self
		assert: (deploymentServices isDeployedComponentImplementation:
				 MolCompleteComponentImpl)
		equals: true.
	self
		assert: (MolUtils isInstantiateComponentOf: MolBasicComponentImpl)
		equals: false.
	self
		assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl)
		equals: false.
	self
		assert: (homeServices isWaitingForActivation: MolBasicComponentImpl)
		equals: false.
	self
		assert:
		(homeServices isWaitingForActivation: MolCompleteComponentImpl)
		equals: false
]

{ #category : #tests }
MolUtilsTest >> testUsedComponentParameters [

	"potential bugs"
	self assert: (MolUtils usedComponentParameters: nil) isEmpty.
	self assert: (MolUtils usedComponentParameters: 45) isEmpty.
	self assert: (MolUtils usedComponentParameters: Integer) isEmpty.
	self assert: (MolUtils usedComponentParameters: MolDirtyType) isEmpty.
	
	"concrete cases"
	self assert:
		(MolUtils usedComponentParameters: MolComponentImpl) isEmpty.
	self assert:
		(MolUtils usedComponentParameters: MolCompleteComponentImpl)
			notEmpty.
	self
		assert: (MolUtils usedComponentParameters:
				 MolCompleteComponentOverloadImpl) size
		equals: 2.
	self
		assert:
		(MolUtils usedComponentParameters: MolCompleteComponentImpl) first
		equals: MolUsedParameters.
	self assert:
		(MolUtils usedComponentParameters: MolCompleteComponentImpl new)
			notEmpty.
	self
		assert:
		(MolUtils usedComponentParameters: MolCompleteComponentImpl new)
			first
		equals: MolUsedParameters.
	self assert:
		(MolUtils usedComponentParameters: MolCompleteComponent) notEmpty.
	self
		assert:
		(MolUtils usedComponentParameters: MolCompleteComponent) first
		equals: MolUsedParameters.

	self assert:
		(MolUtils usedComponentParameters: MolComponentServices) isEmpty.
	self assert:
		(MolUtils usedComponentParameters: MolComponentParameters) isEmpty.
	self assert:
		(MolUtils usedComponentParameters: MolComponentEvents) isEmpty
]

{ #category : #tests }
MolUtilsTest >> testUsedComponentServices [

	"potential bugs"
	self assert: (MolUtils usedComponentServices: nil) isEmpty.
	self assert: (MolUtils usedComponentServices: 45) isEmpty.
	self assert: (MolUtils usedComponentServices: Integer) isEmpty.
	self assert: (MolUtils usedComponentServices: MolDirtyType) isEmpty.
	
	"concrete cases"
	self assert: (MolUtils usedComponentServices: MolComponentImpl) isEmpty.
	self assert:
		(MolUtils usedComponentServices: MolCompleteComponentImpl) notEmpty.
	self
		assert:
			(MolUtils usedComponentServices: MolCompleteComponentOverloadImpl)
				size
		equals: 2.
	self
		assert:
		(MolUtils usedComponentServices: MolCompleteComponentImpl) first
		equals: MolUsedServices.
	self assert:
		(MolUtils usedComponentServices: MolCompleteComponentImpl new)
			notEmpty.
	self
		assert:
		(MolUtils usedComponentServices: MolCompleteComponentImpl new) first
		equals: MolUsedServices.
	self assert:
		(MolUtils usedComponentServices: MolCompleteComponent) notEmpty.
	self
		assert: (MolUtils usedComponentServices: MolCompleteComponent) first
		equals: MolUsedServices.

	self assert:
		(MolUtils usedComponentServices: MolComponentServices) isEmpty.
	self assert:
		(MolUtils usedComponentServices: MolComponentParameters) isEmpty.
	self assert:
		(MolUtils usedComponentServices: MolComponentEvents) isEmpty
]
