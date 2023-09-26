"
A MolComponentEventsTest is a test class for testing the behavior of MolComponentEvents
"
Class {
	#name : 'MolComponentEventsTest',
	#superclass : 'TestCase',
	#category : 'Molecule-Tests-Cases - Component Contract',
	#package : 'Molecule-Tests',
	#tag : 'Cases - Component Contract'
}

{ #category : 'tests' }
MolComponentEventsTest >> testIsComponentEvents [

	self assert: MolComponentServices isComponentEvents equals: false.
	self assert: MolComponentParameters isComponentEvents equals: false.
	self assert: MolComponentEvents isComponentEvents equals: false.
	
	self assert: MolUsedServices isComponentEvents equals: false.
	self assert: MolUsedParameters isComponentEvents equals: false.
	self assert: MolUsedEvents isComponentEvents equals: true.
]
