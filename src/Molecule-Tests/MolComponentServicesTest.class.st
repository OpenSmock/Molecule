"
A MolComponentServicesTest is a test class for testing the behavior of MolComponentServices
"
Class {
	#name : #MolComponentServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #tests }
MolComponentServicesTest >> testIsComponentServices [


	self deny: MolComponentServices isComponentServices.
	self deny: MolComponentParameters isComponentServices.
	self deny: MolComponentEvents isComponentServices.
	self deny: TraitedClass isComponentServices.
	
	self assert: MolUsedServices isComponentServices.
	self deny: MolUsedParameters isComponentServices.
	self deny: MolUsedEvents isComponentServices.
]
