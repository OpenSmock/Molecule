"
Class for the component tab builder in a system browser
"
Class {
	#name : #RSComponentBuilder,
	#superclass : #RSComponentAbstractBuilder,
	#category : #'Molecule-IDE-Incubators-Tab Builder'
}

{ #category : #initialization }
RSComponentBuilder >> initialize [
	super initialize.
	self renderer: RSComponentRenderer new.
]

{ #category : #hooks }
RSComponentBuilder >> renderIn: aCanvas [

	renderer setUpCanvas: aCanvas.
]
