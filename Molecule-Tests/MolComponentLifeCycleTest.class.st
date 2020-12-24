Class {
	#name : #MolComponentLifeCycleTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #running }
MolComponentLifeCycleTest >> setUp [ 
	
	MolComponentManager cleanUp.
]

{ #category : #running }
MolComponentLifeCycleTest >> tearDown [ 
	
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolComponentLifeCycleTest >> testSwitchComponentsSearchServicesProviderFor [
	"start first implemention of a component contract"
	MolUtils startComponent: MolCompleteComponentImpl.
	
	"test locator services finding"
	self assert: ((MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices) isKindOf: MolCompleteComponentImpl).
	
	"stop and switch implementation by another one"
	MolUtils stopComponent: MolCompleteComponentImpl.
	MolUtils startComponent: MolAugmentedClassToAComponent.
	
	"test locator services finding"
	self assert: ((MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices) isKindOf: MolAugmentedClassToAComponent).
]

{ #category : #tests }
MolComponentLifeCycleTest >> testSwitchComponentsWithKeys [
	| compA1 compB |
	"start first implemention of a component contract"
	compA1 := MolUtils startComponent: MolCompleteComponentImpl named: #compA.
	compB := MolUtils startComponent: MolCompleteComponentImpl named: #compB.
	
	"link compB to compA"
	compB forServices: MolUsedServices useProvider: #compA. 
	
	"call the service of the first component, it answer #service"
	self assert: compB getMolUsedServicesProvider service equals: #service.
	
	"switch implementation by another one"
	MolUtils stopComponent: MolCompleteComponentImpl named: #compA.
	MolUtils startComponent: MolAugmentedClassToAComponent named: #compA.
	
	"call the service of the second component (switched), it answer #service2"
	self assert: compB getMolUsedServicesProvider service equals: #service2.
]

{ #category : #tests }
MolComponentLifeCycleTest >> testSwitchComponentsWithKeysSearchServicesProviderFor [
	"start first implemention of a component contract"
	MolUtils startComponent: MolCompleteComponentImpl named: #comp1.
	
	"test locator services finding"
	self assert: ((MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices named: #comp1) isKindOf: MolCompleteComponentImpl).
	
	"stop and switch implementation by another one"
	MolUtils stopComponent: MolCompleteComponentImpl named: #comp1.
	MolUtils startComponent: MolAugmentedClassToAComponent named: #comp1.
	
	"test locator services finding"
	self assert: ((MolComponentManager default locatorServices searchServicesProviderFor: MolUsedServices named: #comp1) isKindOf: MolAugmentedClassToAComponent).
]
