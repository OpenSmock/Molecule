"
class abstract component renderer 
"
Class {
	#name : #RSAbstractComponentRenderer,
	#superclass : #RSObject,
	#instVars : [
		'border',
		'boxBorder',
		'boxColor',
		'layout',
		'textColor'
	],
	#category : #'Molecule-IDE-Incubator-Tab Renderer'
}

{ #category : #testing }
RSAbstractComponentRenderer class >> isAbstract [ 

	^self name = #RSAbstractComponentRenderer
]

{ #category : #initialization }
RSAbstractComponentRenderer >> defaultLayout [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractComponentRenderer >> setUpCanvas: aCanvas [
]

{ #category : #hooks }
RSAbstractComponentRenderer >> shapeFor: anObject [
	^ self subclassResponsibility
]
