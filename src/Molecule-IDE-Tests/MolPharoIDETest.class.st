"
Tests on Pharo IDE features (i.e. inspector).
"
Class {
	#name : #MolPharoIDETest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolPharoIDETest >> setUp [

	super setUp.
	MolComponentManager cleanUp
]

{ #category : #running }
MolPharoIDETest >> tearDown [

	MolComponentManager cleanUp.
	super tearDown
]

{ #category : #running }
MolPharoIDETest >> testInspectComponent [

	| component inspector window |
	component := MolBasicComponentImpl start.
	inspector := (Smalltalk tools toolNamed: #inspector).
	window := inspector inspect: self.
	self assert: window isOpen.
	
	window close.
]

{ #category : #running }
MolPharoIDETest >> testInspectComponentWithNew [

	| component inspector window |
	component := MolBasicComponentImpl new.
	inspector := (Smalltalk tools toolNamed: #inspector).
	window := inspector inspect: self.
	self assert: window isOpen.
	
	window close.
]
