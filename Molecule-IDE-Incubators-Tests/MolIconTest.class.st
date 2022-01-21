Class {
	#name : #MolIconTest,
	#superclass : #TestCase,
	#instVars : [
		'molIcon'
	],
	#category : #'Molecule-IDE-Incubators-Tests-Cases'
}

{ #category : #running }
MolIconTest >> setUp [
	super setUp.
	molIcon := MolIcon new.
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
MolIconTest >> testIconSelectedSearch [
	self assert: (molIcon iconSelectedSearch) equals: (molIcon moleculeIconSelectedSearchStream)
]
