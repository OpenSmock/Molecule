"
A visitor of MolViewElement that try to found an element having for rsobject the same as the one define with the find method.

It is use when a port is drag on the canvas in MolViewPortDrag.
1) when you stop the drag of a port, the final position is save.
2) the canvas is ask to return the first shape at the current position.
3) with the shape, we try to find the corresponding MolViewElement.

This method is currently ineffective since the visitor will search all the elements in the space and will not stop after founding the correct element.
"
Class {
	#name : #MolViewVisitorElementByShape,
	#superclass : #Object,
	#instVars : [
		'shapeToSearch',
		'found'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'typing/selecting keys' }
MolViewVisitorElementByShape >> find: aShape [ 
	shapeToSearch := aShape.
]

{ #category : #accessing }
MolViewVisitorElementByShape >> found [
	^ found
]

{ #category : #initialization }
MolViewVisitorElementByShape >> initialize [ 
	found := nil.
	shapeToSearch := nil.
]

{ #category : #visiting }
MolViewVisitorElementByShape >> visit: aMolViewElement [
	"stop the research after finding the first element."
	found ifNil: [
		(aMolViewElement rsobject = shapeToSearch) ifTrue: [ found := aMolViewElement ]].
]
