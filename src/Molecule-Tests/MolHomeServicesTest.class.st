"
I test a lot of basics methods:
- componentManager creation;
- component life cycle (instanciate, activate, passivate,  remove + additional methods of Utils class as create, start);
- testing methods (instanceKindOf: and others via other tests).

I do not worry about interactions between components. See:
- MyWarningSystemTest for events;
- MyTableTest for services;
- MySocketTest for parameters (and services);
- MyClockSystem for a global example.
"
Class {
	#name : 'MolHomeServicesTest',
	#superclass : 'TestCase',
	#category : 'Molecule-Tests-Cases',
	#package : 'Molecule-Tests',
	#tag : 'Cases'
}

{ #category : 'setUp-tearDown' }
MolHomeServicesTest >> setUp [

	MolComponentManager cleanUp.
]

{ #category : 'setUp-tearDown' }
MolHomeServicesTest >> tearDown [

	MolComponentManager cleanUp.
]

{ #category : 'tests' }
MolHomeServicesTest >> testActivateComponent [
	"Test Component properties after activation"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation:
		MolCompleteComponentImpl.
	component := manager homeServices instantiateComponent:
		             MolCompleteComponentImpl.
	manager homeServices activateComponent: MolCompleteComponentImpl.

	self
		assert: component componentName
		equals: MolUtils defaultComponentName.
	self assert:
		(component componentConnector isKindOf: MolComponentConnector).
	self assert: component eventsNotifiers notEmpty.
	self assert: component eventsSubscribers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testActivateComponentAugmentedClass [
	"Test Component properties after activation"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation:
		MolAugmentedClassToAComponent.
	component := manager homeServices instantiateComponent:
		             MolAugmentedClassToAComponent.
	manager homeServices activateComponent: MolAugmentedClassToAComponent.

	self
		assert: component componentName
		equals: MolUtils defaultComponentName.
	self assert:
		(component componentConnector isKindOf: MolComponentConnector).
	self assert: component eventsNotifiers notEmpty.
	self assert: component eventsSubscribers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty.

	component
		forServices: MolServicesTest
		useProvider: MolUtils defaultComponentName.
	component
		forEvents: MolEventsTest
		useProducer: MolUtils defaultComponentName.
	component
		forParameters: MolParametersTest
		useProvider: MolUtils defaultComponentName
]

{ #category : 'tests' }
MolHomeServicesTest >> testActivateComponentNamed [
	"Test Component properties after activation"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation:
		MolCompleteComponentImpl.
	component := manager homeServices
		             instantiateComponent: MolCompleteComponentImpl
		             named: #testComponent.
	manager homeServices
		activateComponent: MolCompleteComponentImpl
		named: #testComponent.

	self assert: component componentName equals: #testComponent.
	self assert:
		(component componentConnector isKindOf: MolComponentConnector).
	self assert: component eventsNotifiers notEmpty.
	self assert: component eventsSubscribers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty
]

{ #category : 'test' }
MolHomeServicesTest >> testCheckComponentInstantiationPermissionNamed [

	| homeServices result |
	homeServices := MolComponentManager default homeServices.
	
	result := homeServices checkComponentInstantiationPermission: nil named: nil. 
	self assert: result class equals: WrongComponentNameError.
	
	result := homeServices checkComponentInstantiationPermission: MolCompleteComponentImpl named: #default. 
	self assert: result class equals: ComponentNotDeployedError.
	
	MolCompleteComponentImpl deploy.
	result := homeServices checkComponentInstantiationPermission: MolCompleteComponentImpl named: #default. 
	self assert: result isNil.
	
	MolCompleteComponentImpl start.
	result := homeServices checkComponentInstantiationPermission: MolCompleteComponentImpl named: #default. 
	self assert: result class equals: ComponentAlreadyExistsError.
]

{ #category : 'tests' }
MolHomeServicesTest >> testInstantiateComponent [
	"Test Component properties after instantiation"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	component := manager homeServices instantiateComponent: MolCompleteComponentImpl.

	self assert: component componentName equals: MolUtils defaultComponentName.
	self assert: (component componentConnector isKindOf: MolComponentConnector).
	self assert: component eventsNotifiers notEmpty.
	self assert: component eventsSubscribers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testInstantiateComponentNamed [
	"Test Component properties after instanciation"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	component := manager homeServices instantiateComponent: MolCompleteComponentImpl named: #testComponent.

	self assert: component componentName equals: #testComponent.
	self assert: (component componentConnector isKindOf: MolComponentConnector).
	self assert: component eventsNotifiers notEmpty.
	self assert: component eventsSubscribers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty
]

{ #category : 'test - errors' }
MolHomeServicesTest >> testInstantiateComponentWithOverridedInstanciateTypeAndSameName [
	"Test exception appear"

	| manager error |
	error := nil.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentChildImpl.

	"normal case"
	manager homeServices instantiateComponent: MolCompleteComponentImpl.
	error := nil.
	[
	manager homeServices instantiateComponent: MolCompleteComponentChildImpl named: #compB ]
		on: Error
		do: [ :e | error := e ].
	self assert: error isNil.
	manager homeServices removeComponent: MolCompleteComponentImpl.
	manager homeServices removeComponent: MolCompleteComponentChildImpl named: #compB.

	"error case"
	manager homeServices instantiateComponent: MolCompleteComponentImpl.
	error := nil.
	[
	manager homeServices instantiateComponent: MolCompleteComponentChildImpl ]
		on: Error
		do: [ :e | error := e ].
	self assert:
		(error isKindOf: ComponentProvidedServicesAlreadyExistsError)
]

{ #category : 'test - errors' }
MolHomeServicesTest >> testInstantiateComponentWithSameNameAndServices [
	"Test exception appear"

	| manager error |
	error := nil.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	manager deploymentServices deployComponentImplementation: MolCompleteComponent2Impl.

	"normal case"
	manager homeServices instantiateComponent: MolCompleteComponentImpl.
	error := nil.
	[
	manager homeServices instantiateComponent: MolCompleteComponent2Impl named: #compB ]
		on: Error
		do: [ :e | error := e ].
	self assert: error isNil.
	manager homeServices removeComponent: MolCompleteComponentImpl.
	manager homeServices removeComponent: MolCompleteComponent2Impl named: #compB.

	"error case"
	manager homeServices instantiateComponent: MolCompleteComponentImpl.
	error := nil.
	[
	manager homeServices instantiateComponent: MolCompleteComponent2Impl ]
		on: Error
		do: [ :e | error := e ].
	self assert:
		(error isKindOf: ComponentProvidedServicesAlreadyExistsError)
]

{ #category : 'test - errors' }
MolHomeServicesTest >> testInstantiateComponentWithSameNameAndType [
	"Test exception appear"

	| manager error |
	error := nil.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl.
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl2.

	"normal case"
	manager homeServices instantiateComponent: MolBasicComponentImpl.
	error := nil.
	[
	manager homeServices instantiateComponent: MolBasicComponentImpl2 named: #compB ]
		on: Error
		do: [ :e | error := e ].
	self assert: error isNil.
	manager homeServices removeComponent: MolBasicComponentImpl.
	manager homeServices removeComponent: MolBasicComponentImpl2 named: #compB.

	"error case"
	manager homeServices instantiateComponent: MolBasicComponentImpl.
	error := nil.
	[ manager homeServices instantiateComponent: MolBasicComponentImpl2 ]
		on: Error
		do: [ :e | error := e ].
	self assert: (error isKindOf: ComponentAlreadyExistsError)
]

{ #category : 'tests' }
MolHomeServicesTest >> testPassivateComponent [
	"Test Component properties after passivation"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	component := manager homeServices instantiateComponent: MolCompleteComponentImpl.
	manager homeServices activateComponent: MolCompleteComponentImpl.
	manager homeServices passivateComponent: MolCompleteComponentImpl.

	self assert: component componentName equals: MolUtils defaultComponentName.
	self assert: (component componentConnector isKindOf: MolComponentConnector).
	self assert: component eventsNotifiers notEmpty.
	self assert: component eventsSubscribers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testPassivateComponentNamed [
	"Test Component properties after passivation"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	component := manager homeServices instantiateComponent: MolCompleteComponentImpl named: #testComponent.
	manager homeServices activateComponent: MolCompleteComponentImpl named: #testComponent.
	manager homeServices passivateComponent: MolCompleteComponentImpl named: #testComponent.

	self assert: component componentName equals: #testComponent.
	self assert: (component componentConnector isKindOf: MolComponentConnector).
	self assert: component eventsNotifiers notEmpty.
	self assert: component eventsSubscribers notEmpty.
	self assert: component parametersProviders notEmpty.
	self assert: component servicesProviders notEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testRemoveAllComponents [
	"Test Component release on a remove"

	| manager |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.

	manager homeServices instantiateComponent: MolCompleteComponentImpl named: #comp1.
	manager homeServices instantiateComponent: MolCompleteComponentImpl named: #comp2.
	manager homeServices instantiateComponent: MolCompleteComponentImpl named: #comp3.
	manager homeServices activateComponent: MolCompleteComponentImpl named: #comp1.
	manager homeServices activateComponent: MolCompleteComponentImpl named: #comp2.
	manager homeServices passivateComponent: MolCompleteComponentImpl named: #comp2.

	self assert: (manager homeServices isDeployedComponent: MolCompleteComponentImpl) equals: true.
	self assert: (manager homeServices deployedComponents at: MolCompleteComponentImpl) notEmpty.
	self assert: manager homeServices waitingForActivation notEmpty.

	manager homeServices removeAllComponents.

	self assert: (manager homeServices isDeployedComponent: MolCompleteComponentImpl) equals: true.
	self assert: (manager homeServices deployedComponents at: MolCompleteComponentImpl) isEmpty.
	self assert: manager homeServices waitingForActivation isEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testRemoveComponent [
	"Test Component release on a remove"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation:
		MolCompleteComponentImpl.
	component := manager homeServices instantiateComponent:
		             MolCompleteComponentImpl.
	manager homeServices activateComponent: MolCompleteComponentImpl.
	manager homeServices passivateComponent: MolCompleteComponentImpl.
	manager homeServices removeComponent: MolCompleteComponentImpl.

	"Check all components properties"
	self assert: component componentName isNil.
	self assert: component componentConnector isNil.
	self
		assert: component eventsNotifiers
		equals: MolComponentConnector defaultEventsNotifiers.
	self
		assert: component eventsSubscribers
		equals: MolComponentConnector defaultEventsSubscribers.
	self
		assert: component parametersProviders
		equals: MolComponentConnector defaultParametersProviders.
	self
		assert: component servicesProviders
		equals: MolComponentConnector defaultServicesProviders
]

{ #category : 'tests' }
MolHomeServicesTest >> testRemoveComponentNamed [
	"Test Component release on a remove"

	| manager component |
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation:
		MolCompleteComponentImpl.
	component := manager homeServices
		             instantiateComponent: MolCompleteComponentImpl
		             named: #testComponent.
	manager homeServices
		activateComponent: MolCompleteComponentImpl
		named: #testComponent.
	manager homeServices
		passivateComponent: MolCompleteComponentImpl
		named: #testComponent.
	manager homeServices
		removeComponent: MolCompleteComponentImpl
		named: #testComponent.

	"Check all components properties"
	self assert: component componentName isNil.
	self assert: component componentConnector isNil.
	self
		assert: component eventsNotifiers
		equals: MolComponentConnector defaultEventsNotifiers.
	self
		assert: component eventsSubscribers
		equals: MolComponentConnector defaultEventsSubscribers.
	self
		assert: component parametersProviders
		equals: MolComponentConnector defaultParametersProviders.
	self
		assert: component servicesProviders
		equals: MolComponentConnector defaultServicesProviders
]

{ #category : 'tests' }
MolHomeServicesTest >> testRemoveComponentNamedIfAbsent [
	"Test Component release on a remove"

	| manager result catched |
	manager := MolComponentManager default.
	result := manager homeServices
		          removeComponent: MolCompleteComponentImpl
		          named: #testComponent
		          ifAbsent: [ 'Totoro' ].
	self assert: result equals: 'Totoro'.

	result := 'NONE'.
	[result := manager homeServices
		          removeComponent: MolCompleteComponentImpl
		          named: #testComponent] on: ComponentNotFoundError
	do:[ catched := true].
	self assert: result equals: 'NONE'.
	self assert: catched equals: true.

	
]

{ #category : 'tests' }
MolHomeServicesTest >> testSeveralComponentsLifecycle [
	"Test life cycle of several components"

	| manager |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolBasicComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolCompleteComponentImpl.

	"Test method instanciateAllComponents"
	manager homeServices instantiateAllComponents.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl).
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl).
	self assert:
		(manager homeServices isWaitingForActivation:
			 MolCompleteComponentImpl).

	"Test method activateAllComponents"
	manager homeServices activateAllComponents.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl).
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl)
			not.
	self assert:
		(manager homeServices isWaitingForActivation:
			 MolCompleteComponentImpl) not.

	"Test method passivateAllComponents"
	manager homeServices passivateAllComponents.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl).
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl).
	self assert:
		(manager homeServices isWaitingForActivation:
			 MolCompleteComponentImpl).

	"Test method removeAllComponents"
	manager homeServices removeAllComponents.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl) not.
	self assert:
		(MolUtils isInstantiateComponentOf: MolCompleteComponentImpl) not.
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl)
			not.
	self assert:
		(manager homeServices isWaitingForActivation:
			 MolCompleteComponentImpl) not
]

{ #category : 'tests' }
MolHomeServicesTest >> testSeveralComponentsLifecycleWithName [
	"Test life cycle of several components with names"

	| manager |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolBasicComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolBasicComponentImpl2.

	manager homeServices
		instantiateComponent: MolBasicComponentImpl
		named: #component1.
	manager homeServices instantiateComponent: MolBasicComponentImpl.
	manager homeServices
		instantiateComponent: MolBasicComponentImpl2
		named: #component2.

	"Test method activateAllComponents"
	manager homeServices activateAllComponents.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #component1).
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl2
			 named: #component2).
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl
			 named: #component1) not.
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl)
			not.
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl2
			 named: #component2) not.

	"Test method passivateAllComponents"
	manager homeServices passivateAllComponents.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #component1).
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl2
			 named: #component2).
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl
			 named: #component1).
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl).
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl2
			 named: #component2).

	manager homeServices removeAllComponents.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #component1) not.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl) not.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl2
			 named: #component2) not
]

{ #category : 'test - errors' }
MolHomeServicesTest >> testStartAndStopComponentsAlreadyExists [
	"Test exception appear"

	| manager error |
	error := nil.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation:
		MolBasicComponentImpl.

	manager homeServices instantiateComponent: MolBasicComponentImpl.
	[ manager homeServices instantiateComponent: MolBasicComponentImpl ]
		on: Error
		do: [ :e | error := e ].
	self assert: (error isKindOf: ComponentAlreadyExistsError).

	manager homeServices activateComponent: MolBasicComponentImpl.
	[ manager homeServices activateComponent: MolBasicComponentImpl ]
		on: Error
		do: [ :e | error := e ].
	self assert: (error isKindOf: ComponentAlreadyActivatedError).

	manager homeServices passivateComponent: MolBasicComponentImpl.
	[ manager homeServices passivateComponent: MolBasicComponentImpl ]
		on: Error
		do: [ :e | error := e ].
	self assert: (error isKindOf: ComponentAlreadyPassivatedError).

	error := nil.
	manager homeServices removeComponent: MolBasicComponentImpl.
	[ manager homeServices removeComponent: MolBasicComponentImpl ]
		on: Error
		do: [ :e | error := e ].
	self assert: (error isKindOf: ComponentNotFoundError)
]

{ #category : 'test - errors' }
MolHomeServicesTest >> testStartAndStopComponentsNoExist [
	"Test exception appear"
	| manager error |

	error := nil.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolBasicComponentImpl.
	
	error := nil.
	[manager homeServices activateComponent: MolBasicComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentNotFoundError).

	error := nil.
	[manager homeServices passivateComponent: MolBasicComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentNotFoundError).

	error := nil.
	[manager homeServices removeComponent: MolBasicComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentNotFoundError).
]

{ #category : 'test - errors' }
MolHomeServicesTest >> testStartNotDeployedComponent [
	"Test exception appear"

	| manager error |
	error := nil.
	manager := MolComponentManager default.

	error := nil.
	[ manager homeServices instantiateComponent: MolBasicComponentImpl ]
		on: Error
		do: [ :e | error := e ].

	self assert: (error isKindOf: ComponentNotDeployedError)
]

{ #category : 'tests' }
MolHomeServicesTest >> testSubComponentLifecycle [
	"test life cycle of a component using AbstractComponentImpl as super class"

	| manager component |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolBasicComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.

	"Instanciation"
	component := manager homeServices instantiateComponent:
		             MolBasicComponentImpl.
	self assert: component class equals: MolBasicComponentImpl.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl).
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl).

	"Activation"
	manager homeServices activateComponent: MolBasicComponentImpl.
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl)
			not.

	"Passivation"
	manager homeServices passivateComponent: MolBasicComponentImpl.
	self assert:
		(manager homeServices isWaitingForActivation: MolBasicComponentImpl).

	"Deletion"
	manager homeServices removeComponent: MolBasicComponentImpl.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicComponentImpl) not.

	"Undeployment"
	manager deploymentServices undeployComponentImplementation:
		MolBasicComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testSubComponentLifecycleWithName [
	"test life cycle of a component using AbstractComponentImpl as super class with a name"

	| manager |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolBasicComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.

	"Instanciation"
	manager homeServices
		instantiateComponent: MolBasicComponentImpl
		named: #myComp.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #myComp).
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl
			 named: #myComp).

	"Activation"
	manager homeServices
		activateComponent: MolBasicComponentImpl
		named: #myComp.
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl
			 named: #myComp) not.

	"Passivation"
	manager homeServices
		passivateComponent: MolBasicComponentImpl
		named: #myComp.
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl
			 named: #myComp).

	"Deletion"
	manager homeServices
		removeComponent: MolBasicComponentImpl
		named: #myComp.
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicComponentImpl
			 named: #myComp) not.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicComponentImpl
			 named: #myComp) not.

	"Undeployment"
	manager deploymentServices undeployComponentImplementation:
		MolBasicComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testTraitComponentLifecycle [
	"test life cycle of a component using ComponentImpl trait"

	| manager |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.

	"Instanciation"
	manager homeServices instantiateComponent: MolBasicTraitComponentImpl.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicTraitComponentImpl).
	self assert: (manager homeServices isWaitingForActivation:
			 MolBasicTraitComponentImpl).

	"Activation"
	manager homeServices activateComponent: MolBasicTraitComponentImpl.
	self assert: (manager homeServices isWaitingForActivation:
			 MolBasicTraitComponentImpl) not.

	"Passivation"
	manager homeServices passivateComponent: MolBasicTraitComponentImpl.
	self assert: (manager homeServices isWaitingForActivation:
			 MolBasicTraitComponentImpl).

	"Deletion"
	manager homeServices removeComponent: MolBasicTraitComponentImpl.
	self assert: (manager homeServices isWaitingForActivation:
			 MolBasicTraitComponentImpl) not.
	self assert:
		(MolUtils isInstantiateComponentOf: MolBasicTraitComponentImpl) not.

	"Undeployment"
	manager deploymentServices undeployComponentImplementation:
		MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty
]

{ #category : 'tests' }
MolHomeServicesTest >> testTraitComponentLifecycleWithName [
	"test life cycle of a component using ComponentImpl trait with a name"

	| manager |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.

	"Instanciation"
	manager homeServices
		instantiateComponent: MolBasicTraitComponentImpl
		named: #myComp.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicTraitComponentImpl
			 named: #myComp).
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicTraitComponentImpl
			 named: #myComp).

	"Activation"
	manager homeServices
		activateComponent: MolBasicTraitComponentImpl
		named: #myComp.
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicTraitComponentImpl
			 named: #myComp) not.

	"Passivation"
	manager homeServices
		passivateComponent: MolBasicTraitComponentImpl
		named: #myComp.
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicTraitComponentImpl
			 named: #myComp).

	"Deletion"
	manager homeServices
		removeComponent: MolBasicTraitComponentImpl
		named: #myComp.
	self assert: (manager homeServices
			 isWaitingForActivation: MolBasicTraitComponentImpl
			 named: #myComp) not.
	self assert: (MolUtils
			 isInstantiateComponentOf: MolBasicTraitComponentImpl
			 named: #myComp) not.

	"Undeployment"
	manager deploymentServices undeployComponentImplementation:
		MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty
]
