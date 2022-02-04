"
Class for the component tab builder in a system browser (Abstract)
"
Class {
	#name : #RSComponentAbstractBuilder,
	#superclass : #RSAbstractShapesBuilder,
	#instVars : [
		'renderer'
	],
	#category : #'Molecule-IDE-Incubators-Tab Builder'
}

{ #category : #defaults }
RSComponentAbstractBuilder >> defaultContainer [
	^RSCanvas new 
		addInteraction: RSCanvasController new;
		yourself.
]

{ #category : #accessing }
RSComponentAbstractBuilder >> renderer [
	^ renderer
]

{ #category : #accessing }
RSComponentAbstractBuilder >> renderer: aRSComponentRenderer [
	renderer := aRSComponentRenderer.
]
