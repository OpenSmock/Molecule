"
Class for the component tab builder in a system browser (Abstract)
"
Class {
	#name : #RSComponentAbstractBuilder,
	#superclass : #RSAbstractShapesBuilder,
	#category : #'Molecule-IDE-Incubators-Tab Builder'
}

{ #category : #defaults }
RSComponentAbstractBuilder >> defaultContainer [
	^ RSCanvas new 
		addInteraction: RSCanvasController new;
		yourself.
]
