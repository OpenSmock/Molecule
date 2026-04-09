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

{ #category : #'tests - component switching' }
MolComponentLifeCycleTest >> testStartAndStopComponentSeveralTimes [
	"This test reproduce issue #246: Exception after several starts and stops of same component"

	| compA compB |
	"start first implemention of a component contract"
	compA := MolCompleteComponentImpl start: #compA.
	compB := MolCompleteComponentImpl start: #compB.
	
	"link compB to compA"
	compB forServices: MolUsedServices useProvider: #compA. 
	compB forEvents: MolUsedEvents useProducer: #compA. 
	compB getMolUsedEventsSubscriber subscribe: compB.
	
	"call the service of the first component, it answer #service"
	self assert: compB getMolUsedServicesProvider service equals: #service.
	
	"stop and start component several times"
	1 to: 10 do:[ :i |
		compB forEvents: MolUsedEvents removeProducer: #compA.
		compB class stop: #compB.
		compB := MolCompleteComponentImpl start: #compB.
		compB forServices: MolUsedServices useProvider: #compA. 
		compB forEvents: MolUsedEvents useProducer: #compA. 
		compB getMolUsedEventsSubscriber subscribe: compB.
		self assert: compB getMolUsedServicesProvider service equals: #service.
	].

	
]

{ #category : #'tests - component switching' }
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

{ #category : #'tests - component switching' }
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

{ #category : #'tests - component switching' }
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
