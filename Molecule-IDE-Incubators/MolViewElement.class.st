"
This is the base element for Molecule View.

It contains a rsobject of class RSObject that contain the element to be draw.
"
Class {
	#name : #MolViewElement,
	#superclass : #Object,
	#instVars : [
		'rsobject'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #accessing }
MolViewElement >> rsobject [
	^ rsobject
]
