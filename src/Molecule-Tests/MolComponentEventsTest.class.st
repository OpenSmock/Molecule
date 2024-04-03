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

	self deny: MolComponentServices isComponentEvents.
	self deny: MolComponentParameters isComponentEvents.
	self deny: MolComponentEvents isComponentEvents.
	self deny: TraitedClass isComponentEvents.
	
	self deny: MolUsedServices isComponentEvents.
	self deny: MolUsedParameters isComponentEvents.
	self assert: MolUsedEvents isComponentEvents.
]
