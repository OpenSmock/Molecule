"
This is the base element for Molecule View.

It contains a rsobject of class RSObject that contain the element to be draw.
"
Class {
	#name : #MolViewElement,
	#superclass : #Object,
	#instVars : [
		'rsobject',
		'space'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #testing }
MolViewElement >> isConnector [
	^false
]

{ #category : #testing }
MolViewElement >> isPort [
	^false
]

{ #category : #testing }
MolViewElement >> isViewComponent [
	^false.
]

{ #category : #accessing }
MolViewElement >> rsobject [
	^ rsobject
]

{ #category : #accessing }
MolViewElement >> space [
	^space.
]

{ #category : #accessing }
MolViewElement >> space: aSpace [
	space := aSpace.
]

{ #category : #visitor }
MolViewElement >> visitedBy: aVisitor [ 
	self subclassResponsibility.
]
