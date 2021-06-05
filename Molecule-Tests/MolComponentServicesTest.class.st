"
A MolComponentServicesTest is a test class for testing the behavior of MolComponentServices
"
Class {
	#name : #MolComponentServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases - Component Contract'
}

{ #category : #tests }
MolComponentServicesTest >> testIsComponentServices [

	self assert: MolComponentServices isComponentServices equals: false.
	self assert: MolComponentParameters isComponentServices equals: false.
	self assert: MolComponentEvents isComponentServices equals: false.
	
	self assert: MolUsedServices isComponentServices equals: true.
	self assert: MolUsedParameters isComponentServices equals: false.
	self assert: MolUsedEvents isComponentServices equals: false.
]
