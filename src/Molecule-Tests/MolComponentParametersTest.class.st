"
A MolComponentParametersTest is a test class for testing the behavior of MolComponentParameters
"
Class {
	#name : #MolComponentParametersTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolComponentParametersTest >> testIsComponentParameters [

	self deny: MolComponentServices isComponentParameters.
	self deny: MolComponentParameters isComponentParameters.
	self deny: MolComponentEvents isComponentParameters.
	self deny: TraitedClass isComponentParameters.
	
	self deny: MolUsedServices isComponentParameters.
	self assert: MolUsedParameters isComponentParameters.
	self deny: MolUsedEvents isComponentParameters.
]
