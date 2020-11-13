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

	self class environment at: self generatedClass ifAbsent:[
		MolComponentFactory
			createImplementationFor: MolCompleteComponent
			named: self generatedClass
			in: 'Molecule-Tests-Resources'.
	].
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentFactoryDefaultClass [

	MolComponentFactory cleanUp.

	self assert: MolComponentFactory default class equals: MolComponentFactory.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.
	
	MolComponentFactory cleanUp.
]

{ #category : #tests }
MolComponentFactoryTest >> testCreateImplementationForNamedIn [
	"delete generated class if presents"
	
	| class |
	self class environment
		at: self generatedClass
		ifPresent: [ (self class environment at: self generatedClass) removeFromSystem ].
		
	MolComponentFactory
		createImplementationFor: MolCompleteComponent
		named: self generatedClass
		in: 'Molecule-Tests-Resources'.

	class := self class environment at: self generatedClass.
	self assert: class notNil.
	class comment: 'I am added and removed by test: ', self printString.
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
