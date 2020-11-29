"
A MolComponentFactoryTest is a test class for testing the behavior of MolComponentFactory
"
Class {
	#name : #MolComponentFactoryTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolComponentFactoryTest >> generatedClass [
	^ #MolCompleteComponentTestImpl.
]

{ #category : #'setUp-tearDown' }
MolComponentFactoryTest >> setUp [

	self setUpComponentAndType.
]

{ #category : #'setUp-tearDown' }
MolComponentFactoryTest >> setUpComponentAndType [
	"Prepare or reset required test classes"
	
	| methodName source |
	self class environment at: self generatedClass ifAbsent:[
		MolComponentFactory
			createComponentForType: MolCompleteComponent
			named: self generatedClass
			in: 'Molecule-Tests-Resources'.
	].

	methodName := 'usedComponentServices'.
	source := String streamContents: [ :s | 
		s nextPutAll: methodName. 
		s nextPut: Character cr. 
		s nextPutAll: '<componentContract>'.
		s nextPut: Character cr.
		s nextPutAll: '^{ MolUsedServices }'.
	].
	MolCompleteComponent class compile: source.
]

{ #category : #'setUp-tearDown' }
MolComponentFactoryTest >> tearDown [

	self setUpComponentAndType.
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentChangedOnComponentCreationWithoutType [
	"Create a class, edit this class from different ways and check if the factory define the component or not"
	
	| isDynamicContractUpdateActivated |
	self assert: MolComponentFactory default dirtyComponents isEmpty.
	
	"For testing deactive the dynamic contract update, store the previous setting for restore it at the end of the test"
	isDynamicContractUpdateActivated := MolComponentFactory default isDynamicContractUpdateActivated.
	MolComponentFactory default deactivateDynamicContractUpdate.
	
	"remove the testing class, and create a new component without Type, when the type is added check if the component in on the dirty components list"
	self class environment at: self generatedClass ifPresent: [ (self class environment at: self generatedClass) removeFromSystem ].
	MolComponentFactory createComponentNamed: self generatedClass in: 'Molecule-Tests-Resources'.
	
	"Waiting for event callback"
	(Delay forMilliseconds: 100) wait.
	self assert: (MolComponentFactory default dirtyComponents includes: (self generatedClass asClass)).
	MolComponentFactory default dirtyComponents removeAll.
	
	"add the type manually to the created component"
	self generatedClass asClass setTraitComposition: MolCompleteComponent.
	"Waiting for event callback"
	(Delay forMilliseconds: 100) wait.
	self assert: (MolComponentFactory default dirtyComponents includes: (self generatedClass asClass)).
	MolComponentFactory default dirtyComponents removeAll.
	
	"remove the testing class, and create a new component with Type, check if the component in on the dirty components list"
	self class environment at: self generatedClass ifPresent: [ (self class environment at: self generatedClass) removeFromSystem ].
	MolComponentFactory createComponentForType: MolCompleteComponent named: self generatedClass in: 'Molecule-Tests-Resources'.
	
	"Waiting for event callback"
	(Delay forMilliseconds: 100) wait.
	self assert: (MolComponentFactory default dirtyComponents includes: (self generatedClass asClass)).
	MolComponentFactory default dirtyComponents removeAll.
	
	isDynamicContractUpdateActivated ifTrue:[MolComponentFactory default activateDynamicContractUpdate] ifFalse:[MolComponentFactory default deactivateDynamicContractUpdate].
	
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentContractChanged [
	"Create a class, edit this class from different ways and check if the factory define the component or not"
	
	| isDynamicContractUpdateActivated methodName source |
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.
	
	"For testing deactive the dynamic contract update, store the previous setting for restore it at the end of the test"
	isDynamicContractUpdateActivated := MolComponentFactory default isDynamicContractUpdateActivated.
	MolComponentFactory default deactivateDynamicContractUpdate.
	
	"Add manually a new used services in the MolCompleteComponent Type"
	methodName := 'usedComponentServices'.
	source := String streamContents: [ :s | 
		s nextPutAll: methodName. 
		s nextPut: Character cr. 
		s nextPutAll: '<componentContract>'.
		s nextPut: Character cr.
		s nextPutAll: '^{ }'.
	].
	MolCompleteComponent class compile: source.
	
	"Waiting for event callback"
	(Delay forMilliseconds: 100) wait.
	
	self assert: (MolComponentFactory default dirtyComponentTypes includes: MolCompleteComponent).
		
	MolComponentFactory default dirtyComponentTypes removeAll.
	isDynamicContractUpdateActivated ifTrue:[MolComponentFactory default activateDynamicContractUpdate] ifFalse:[MolComponentFactory default deactivateDynamicContractUpdate].
	
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentFactoryDefaultClass [

	MolComponentFactory cleanUp.

	self assert: MolComponentFactory default class equals: MolComponentFactory.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.
	self assert: MolComponentFactory default dirtyComponents isEmpty.
	
	MolComponentFactory cleanUp.
]

{ #category : #tests }
MolComponentFactoryTest >> testCreateComponentForTypeNamedIn [
	"Create a Component from scratch with a Type"
	
	| class |
	"delete generated class if presents"
	self class environment at: self generatedClass ifPresent: [ (self class environment at: self generatedClass) removeFromSystem ].
	MolComponentFactory createComponentForType: MolCompleteComponent named: self generatedClass in: 'Molecule-Tests-Resources'.

	class := self class environment at: self generatedClass.
	self assert: class notNil.
	self assert: class isComponent.
	self assert: class haveComponentType.
	
	class comment: 'I am added and removed by test: ', self printString.
]

{ #category : #tests }
MolComponentFactoryTest >> testCreateComponentNamedIn [
	"Create a Component from scratch without Type"
	
	| class |
	"delete generated class if presents"
	self class environment at: self generatedClass ifPresent: [ (self class environment at: self generatedClass) removeFromSystem ].
	MolComponentFactory createComponentNamed: self generatedClass in: 'Molecule-Tests-Resources'.

	class := self class environment at: self generatedClass.
	self assert: class notNil.
	self assert: class isComponent.
	self assert: class haveComponentType equals: false.
	
	class comment: 'I am added and removed by test: ', self printString.
]

{ #category : #tests }
MolComponentFactoryTest >> testDefineDirtyComponents [

	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.

	"Add a dirty component type manually"
	MolComponentFactory default  dirtyComponentTypes add: MolMyClientComponent.
	MolComponentFactory default  dirtyComponents add: MolMyClientComponentImpl.
	self assert: MolComponentFactory default dirtyComponentTypes notEmpty.
	self assert: MolComponentFactory default dirtyComponents notEmpty.
	
	MolComponentFactory defineDirtyComponents.
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.
	self assert: MolComponentFactory default dirtyComponents isEmpty.
]

{ #category : #tests }
MolComponentFactoryTest >> testDynamicContractUpdateActivation [

	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
	
	MolComponentFactory default isDynamicContractUpdateActivated: false.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: false.
	
	MolComponentFactory default isDynamicContractUpdateActivated: true.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
]

{ #category : #tests }
MolComponentFactoryTest >> testDynamicContractUpdateActivation2 [

	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
	
	MolComponentFactory default deactivateDynamicContractUpdate.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: false.
	
	MolComponentFactory default activateDynamicContractUpdate.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
	
	
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateConsumedEventComponentAccessorsFor [

	MolCompleteComponentImpl removeSelector: #getMolUsedEventsSubscriber.
	MolComponentFactory default generateConsumedEventsComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedEventsSubscriber).
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateProducedEventComponentAccessorsFor [

	MolCompleteComponentImpl removeSelector: #getMolUsedEventsNotifier.
	MolComponentFactory default generateProducedEventsComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedEventsNotifier).
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateUsedParametersComponentAccessorsFor [

	MolCompleteComponentImpl removeSelector: #getMolUsedParametersProvider.
	MolComponentFactory default generateUsedParametersComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedParametersProvider).
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateUsedServicesComponentAccessorsFor [

	MolCompleteComponentImpl removeSelector: #getMolUsedServicesProvider.
	MolComponentFactory default generateUsedServicesComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedServicesProvider).
]
