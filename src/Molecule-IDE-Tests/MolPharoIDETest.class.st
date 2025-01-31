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

	| component inspector |
	component := MolBasicComponentImpl start.
	self flag:'pla: this test is manual, need to test if there is an error automatically'.
	inspector := (Smalltalk tools inspector inspect: component).
]

{ #category : #running }
MolPharoIDETest >> testInspectComponentWithNew [

	| component inspector |
	component := MolBasicComponentImpl new.
	self flag:'pla: this test is manual, need to test if there is an error automatically'.
	inspector := (Smalltalk tools inspector inspect: component).
]
