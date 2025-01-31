"
A MolComponentToRoassalTest is a test class for testing the behavior of MolComponentToRoassal
"
Class {
	#name : #MolComponentToRoassalTest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolComponentToRoassalTest >> setUp [

	super setUp.
	MolComponentManager cleanUp
]

{ #category : #running }
MolComponentToRoassalTest >> tearDown [

	MolComponentManager cleanUp.
	super tearDown
]

{ #category : #tests }
MolComponentToRoassalTest >> testAssociationsAllConsumedEventsAndTargetsFor [

	| list component |
	component := MolCompleteComponentImpl start.
	list := MolComponentToRoassal associationsAllConsumedEventsAndTargetsFor: component.
	self assert: list notEmpty.
	
	component := MolCompleteComponentImpl new.
	list := MolComponentToRoassal associationsAllConsumedEventsAndTargetsFor: component.
	self assert: list isEmpty.
]

{ #category : #tests }
MolComponentToRoassalTest >> testAssociationsAllProducedEventsAndTargetsFor [

	| list component |
	component := MolCompleteComponentImpl start.
	list := MolComponentToRoassal associationsAllProducedEventsAndTargetsFor: component.
	self assert: list notEmpty.
	
	component := MolCompleteComponentImpl new.
	list := MolComponentToRoassal associationsAllProducedEventsAndTargetsFor: component.
	self assert: list notEmpty.
]

{ #category : #tests }
MolComponentToRoassalTest >> testAssociationsAllProvidedParametersAndTargetsFor [

	| list component |
	component := MolCompleteComponentImpl start.
	list := MolComponentToRoassal associationsAllProvidedParametersAndTargetsFor: component.
	self assert: list notEmpty.
	
	component := MolCompleteComponentImpl new.
	list := MolComponentToRoassal associationsAllProvidedParametersAndTargetsFor: component.
	self assert: list notEmpty.
]

{ #category : #tests }
MolComponentToRoassalTest >> testAssociationsAllProvidedServicesAndTargetsFor [

	| list component |
	component := MolCompleteComponentImpl start.
	list := MolComponentToRoassal associationsAllProvidedServicesAndTargetsFor: component.
	self assert: list notEmpty.
	
	component := MolCompleteComponentImpl new.
	list := MolComponentToRoassal associationsAllProvidedServicesAndTargetsFor: component.
	self assert: list notEmpty.
]

{ #category : #tests }
MolComponentToRoassalTest >> testAssociationsAllUsedParametersAndTargetsFor [

	| list component |
	component := MolCompleteComponentImpl start.
	list := MolComponentToRoassal associationsAllUsedParametersAndTargetsFor: component.
	self assert: list notEmpty.
	
	component := MolCompleteComponentImpl new.
	list := MolComponentToRoassal associationsAllUsedParametersAndTargetsFor: component.
	self assert: list isEmpty.
]

{ #category : #tests }
MolComponentToRoassalTest >> testAssociationsAllUsedServicesAndTargetsFor [

	| list component |
	component := MolCompleteComponentImpl start.
	list := MolComponentToRoassal associationsAllUsedServicesAndTargetsFor: component.
	self assert: list notEmpty.
	
	component := MolCompleteComponentImpl new.
	list := MolComponentToRoassal associationsAllUsedServicesAndTargetsFor: component.
	self assert: list isEmpty.
]
