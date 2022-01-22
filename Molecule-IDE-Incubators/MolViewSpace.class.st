Class {
	#name : #MolViewSpace,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'elements'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #adding }
MolViewSpace >> addComponent: aComponent [
	| element |
	element := MolViewComponent new initializeComponent: aComponent.
	self addElement: element.
]

{ #category : #adding }
MolViewSpace >> addElement: anElement [
	| rselement |
	
	"TODO: Un element doit etre en charge de sa propre politique. A changer !"
	rselement := anElement rsobject.
	rselement draggable.
	rselement when: RSMouseDragStart do: [ canvas pushFront: rselement ].
	
	anElement space: self.
	elements add: anElement.
	canvas add: (anElement rsobject).
	(RSGridLayout new gapSize: 70) on: (canvas nodes).
]

{ #category : #accessing }
MolViewSpace >> canvas [
	^canvas.
]

{ #category : #initialization }
MolViewSpace >> initialize [
	<script: '(MolViewSpace new 
		addComponent: (MolMyServerTimeComponentImpl new);
		addComponent: (MolMyClockComponentImpl new);
		addComponent: (MolMyUserFacadeComponentImpl new);
		addComponent: (MolMyAlarmComponentImpl new);
		canvas) open.'>

	elements := LinkedList new.
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	canvas zoomToFit.
]

{ #category : #'as yet unclassified' }
MolViewSpace >> triggerHighlightInPortPolicy: aConnector [ 
	elements select: [ :element | (element isViewComponent) ] thenDo: [ :component | component highlightInPortIfConnect: aConnector ].
]

{ #category : #'as yet unclassified' }
MolViewSpace >> triggerHighlightOutPortPolicy: aConnector [ 
	elements select: [ :element | (element isViewComponent) ] thenDo: [ :component | component highlightOutPortIfConnect: aConnector ].
]

{ #category : #'as yet unclassified' }
MolViewSpace >> triggerUnhighlightPortPolicy [
	elements collect: [ :element |
		element isViewComponent ifTrue: [ 
			 element resetPortsColor ]
		].
]
