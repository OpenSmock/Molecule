"
A MolComponentFactoryTest is a test class for testing the behavior of MolComponentFactory
"
Class {
	#name : #MolComponentFactoryTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests'
}

{ #category : #tests }
MolComponentFactoryTest >> generatedClass [

	^ #MolCompleteComponentTestImpl.
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentFactoryBasics [

	self assert: MolComponentFactory default class equals: MolComponentFactory.
	MolComponentFactory cleanUp.
	self assert: MolComponentFactory systemIcon class equals: Form.
]

{ #category : #tests }
MolComponentFactoryTest >> testCreateImplementationForNamedIn [

	
	self generatedClass asClassIfPresent: 
		[ self generatedClass asClass removeFromSystem ].
	MolComponentFactory
		createImplementationFor: MolCompleteComponent
		named: self generatedClass
		in: 'Molecule-Tests'.
	self generatedClass asClass comment: 'I am added and removed by test: ', self printString.
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
