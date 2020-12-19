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
	#name : #MolHomeServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #'setUp-tearDown' }
MolHomeServicesTest >> setUp [

	MolComponentManager cleanUp.
]

{ #category : #'setUp-tearDown' }
MolHomeServicesTest >> tearDown [

	MolComponentManager cleanUp.
]

{ #category : #tests }
MolHomeServicesTest >> testSeveralComponentsLifecycle [
	"Test life cycle of several components"
	| manager |

	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl2.

	"Test method instanciateAllComponents"
	manager homeServices instanciateAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2).

	"Test method activateAllComponents"
	manager homeServices activateAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl) not.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2) not.

	"Test method passivateAllComponents"
	manager homeServices passivateAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2).
	
	"Test method removeAllComponents"
	manager homeServices removeAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl) not.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2) not.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl) not.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2) not.
]

{ #category : #tests }
MolHomeServicesTest >> testSeveralComponentsLifecycleWithName [
"Test life cycle of several components with names"
	| manager |
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl2.

	manager homeServices instanciateComponent: MolBasicSubComponentImpl named: #component1.
	manager homeServices instanciateComponent: MolBasicSubComponentImpl.
	manager homeServices instanciateComponent: MolBasicSubComponentImpl2 named: #component2.

	"Test method activateAllComponents"
	manager homeServices activateAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #component1).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2 named: #component2).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #component1) not.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl) not.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2 named: #component2) not.
	
	"Test method passivateAllComponents"
	manager homeServices passivateAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #component1).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2 named: #component2).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #component1).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl2 named: #component2).
	
	manager homeServices removeAllComponents.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #component1) not.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl) not.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl2 named: #component2) not.
]

{ #category : #tests }
MolHomeServicesTest >> testStartAndStopComponentsAlreadyExists [
	"Test exception appear"
	| manager error |

	error := nil.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	
	manager homeServices instanciateComponent: MolBasicSubComponentImpl.
	[manager homeServices instanciateComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentAlreadyExistsError).
	
	manager homeServices activateComponent: MolBasicSubComponentImpl.
	[manager homeServices activateComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentAlreadyActivatedError).
	
	manager homeServices passivateComponent: MolBasicSubComponentImpl.
	[manager homeServices passivateComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentAlreadyPassivatedError).
	
	error := nil.
	manager homeServices removeComponent: MolBasicSubComponentImpl.
	[manager homeServices removeComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentNotFoundError).
]

{ #category : #tests }
MolHomeServicesTest >> testStartAndStopComponentsNoExist [
	"Test exception appear"
	| manager error |

	error := nil.
	manager := MolComponentManager default.
	manager deploymentServices deployComponentImplementation: MolBasicSubComponentImpl.
	
	error := nil.
	[manager homeServices activateComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentNotFoundError).

	error := nil.
	[manager homeServices passivateComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentNotFoundError).

	error := nil.
	[manager homeServices removeComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].
	self assert: (error isKindOf: ComponentNotFoundError).
]

{ #category : #tests }
MolHomeServicesTest >> testStartNotDeployedComponent [
	"Test exception appear"
	| manager error |

	error := nil.
	manager := MolComponentManager default.
	
	error := nil.
	[manager homeServices instanciateComponent: MolBasicSubComponentImpl] on: Error do:[ :e |
		error := e.
	].

	self assert: (error isKindOf: ComponentNotDeployedError).
]

{ #category : #tests }
MolHomeServicesTest >> testSubComponentLifecycle [
"test life cycle of a component using AbstractComponentImpl as super class"
	| manager component |
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices  deployComponentImplementation: MolBasicSubComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.
	
	"Instanciation"
	component := manager homeServices instanciateComponent: MolBasicSubComponentImpl.
	self assert: component class equals: MolBasicSubComponentImpl.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl).
	
	"Activation"
	manager homeServices activateComponent: MolBasicSubComponentImpl.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl) not.
	
	"Passivation"
	manager homeServices passivateComponent: MolBasicSubComponentImpl.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl).
	
	"Deletion"
	manager homeServices removeComponent: MolBasicSubComponentImpl.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl) not.
	
	"Undeployment"
	manager deploymentServices undeployComponentImplementation: MolBasicSubComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty.
]

{ #category : #tests }
MolHomeServicesTest >> testSubComponentLifecycleWithName [
"test life cycle of a component using AbstractComponentImpl as super class with a name"
	| manager |
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices  deployComponentImplementation: MolBasicSubComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.
	
	"Instanciation"
	manager homeServices instanciateComponent: MolBasicSubComponentImpl named: #myComp.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #myComp).
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #myComp).
	
	"Activation"
	manager homeServices activateComponent: MolBasicSubComponentImpl named: #myComp.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #myComp) not.
	
	"Passivation"
	manager homeServices passivateComponent: MolBasicSubComponentImpl named: #myComp.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #myComp).
	
	"Deletion"
	manager homeServices removeComponent: MolBasicSubComponentImpl named: #myComp.
	self assert: (manager homeServices isWaitingForActivation: MolBasicSubComponentImpl named: #myComp) not.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicSubComponentImpl named: #myComp) not.
	
	"Undeployment"
	manager deploymentServices  undeployComponentImplementation: MolBasicSubComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty.
]

{ #category : #tests }
MolHomeServicesTest >> testTraitComponentLifecycle [
"test life cycle of a component using ComponentImpl trait"
	| manager |
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices  deployComponentImplementation: MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.
	
	"Instanciation"
	manager homeServices instanciateComponent: MolBasicTraitComponentImpl.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicTraitComponentImpl).
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl).
	
	"Activation"
	manager homeServices activateComponent: MolBasicTraitComponentImpl.
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl) not.
	
	"Passivation"
	manager homeServices passivateComponent: MolBasicTraitComponentImpl.
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl).
	
	"Deletion"
	manager homeServices removeComponent: MolBasicTraitComponentImpl.
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl) not.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicTraitComponentImpl) not.
	
	"Undeployment"
	manager deploymentServices  undeployComponentImplementation: MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty.
]

{ #category : #tests }
MolHomeServicesTest >> testTraitComponentLifecycleWithName [
"test life cycle of a component using ComponentImpl trait with a name"
	| manager |
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices  deployComponentImplementation: MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents notEmpty.
	
	"Instanciation"
	manager homeServices instanciateComponent: MolBasicTraitComponentImpl named: #myComp.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicTraitComponentImpl named: #myComp).
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl named: #myComp).
	
	"Activation"
	manager homeServices activateComponent: MolBasicTraitComponentImpl named: #myComp.
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl named: #myComp) not.
	
	"Passivation"
	manager homeServices passivateComponent: MolBasicTraitComponentImpl named: #myComp.
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl named: #myComp).
	
	"Deletion"
	manager homeServices removeComponent: MolBasicTraitComponentImpl named: #myComp.
	self assert: (manager homeServices isWaitingForActivation: MolBasicTraitComponentImpl named: #myComp) not.
	self assert: (MolUtils isInstanciateComponentOf: MolBasicTraitComponentImpl named: #myComp) not.
	
	"Undeployment"
	manager deploymentServices  undeployComponentImplementation: MolBasicTraitComponentImpl.
	self assert: manager homeServices deployedComponents isEmpty.
]
