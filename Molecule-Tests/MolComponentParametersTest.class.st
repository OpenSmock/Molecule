"
A MolComponentParametersTest is a test class for testing the behavior of MolComponentParameters
"
Class {
	#name : #MolComponentParametersTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases - Component Contract'
}

{ #category : #tests }
MolComponentParametersTest >> testIsComponentParameters [

	self assert: MolComponentServices isComponentParameters equals: false.
	self assert: MolComponentParameters isComponentParameters equals: false.
	self assert: MolComponentEvents isComponentParameters equals: false.
	
	self assert: MolUsedServices isComponentParameters equals: false.
	self assert: MolUsedParameters isComponentParameters equals: true.
	self assert: MolUsedEvents isComponentParameters equals: false.
]
