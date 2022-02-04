Class {
	#name : #MolIconTest,
	#superclass : #TestCase,
	#instVars : [
		'molIcon'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolIconTest >> setUp [

	super setUp.

	MolIcon cleanIcons
]

{ #category : #running }
MolIconTest >> tearDown [

	super tearDown.

	MolIcon cleanIcons
]

{ #category : #running }
MolIconTest >> testIcons [

	"Not icons initialized at the beginning"
	self assert: (MolIcon icons isKindOf: Dictionary).
	self assert: MolIcon icons isEmpty.
	
	"initialize somes icons"
	self assert: (MolIcon moleculeIcon isKindOf: Form).
	self assert: (MolIcon moleculeComponentIcon isKindOf: Form).
	
	"clean and check the cleanup"
	MolIcon cleanIcons.
	self assert: (MolIcon icons isKindOf: Dictionary).
	self assert: MolIcon icons isEmpty.
	
	
]
