"
A space that contain every MolViewElement that should be display.

Will in the future probably be a super-class of more specific space.
Will also contain a cursor variable, that will be use to trigger action when used on an MolViewElement.
"
Class {
	#name : #MolViewSpace,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'elements',
		'theme'
	],
	#category : #'Molecule-IDE-Incubator-Mol View'
}

{ #category : #'as yet unclassified' }
MolViewSpace class >> openTest [
	<script>
	(MolViewSpace new 
		addComponent: (MolMyServerTimeComponentImpl new);
		addComponent: (MolMyClockComponentImpl new);
		addComponent: (MolMyUserFacadeComponentImpl new);
		addComponent: (MolMyAlarmComponentImpl new);
		canvas) open extent: 800@600.
]

{ #category : #adding }
MolViewSpace >> addComponent: aComponent [
	| element |
	element := MolViewComponent new: aComponent from: self.
	self addElement: element.
	"TODO: Un element doit etre en charge de sa propre politique. A changer !"
	element rsobject draggable; when: RSMouseDragStart do: [ canvas pushFront: element rsobject ].
]

{ #category : #adding }
MolViewSpace >> addConnectorsRelation: aRelation [ 
	canvas add: (aRelation rsobject).
]

{ #category : #adding }
MolViewSpace >> addElement: anElement [
	anElement space: self.
	elements add: anElement.
	canvas add: (anElement rsobject).
	(RSGridLayout new gapSize: 300) on: (canvas nodes).
]

{ #category : #accessing }
MolViewSpace >> canvas [
	^canvas.
]

{ #category : #'finding/searching' }
MolViewSpace >> findShape: aRSComposite [
	| visitor |
	visitor := MolViewVisitorElementByShape new find: aRSComposite.
	elements do: [ :element | element visitedBy: visitor ].
	^(visitor found).
]

{ #category : #initialization }
MolViewSpace >> initialize [
	
	super initialize.
	
	theme := MolViewUITheme new.
	elements := LinkedList new.
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	canvas zoomToFit.
]

{ #category : #removing }
MolViewSpace >> removeRelation: aRelation [ 
	canvas removeShape: aRelation rsobject.
]

{ #category : #accessing }
MolViewSpace >> theme [
	^theme
]

{ #category : #accessing }
MolViewSpace >> theme: aUiTheme [
	theme := aUiTheme
]

{ #category : #interactions }
MolViewSpace >> triggerHighlightInPortPolicy: aConnector [ 
	elements select: [ :element | (element isViewComponent) ] thenDo: [ :component | component highlightInPortIfConnect: aConnector ].
]

{ #category : #interactions }
MolViewSpace >> triggerHighlightOutPortPolicy: aConnector [ 
	elements select: [ :element | (element isViewComponent) ] thenDo: [ :component | component highlightOutPortIfConnect: aConnector ].
]

{ #category : #interactions }
MolViewSpace >> triggerUnhighlightPortPolicy [
	elements collect: [ :element |
		element isViewComponent ifTrue: [ 
			 element resetPortsColor ]
		].
]
