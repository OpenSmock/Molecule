"
Class for calypso for component tab in browser system
"
Class {
	#name : #RSAbstractComponentCalypso,
	#superclass : #ClyBrowserToolMorph,
	#instVars : [
		'morph'
	],
	#category : #'Molecule-IDE-Incubator-Tab Calypso'
}

{ #category : #testing }
RSAbstractComponentCalypso class >> shouldBeActivatedInContext: aBrowserContext [
	"Subclasses can define extra condition 
	to check that they can be opened in particular browser context instance.
	By default it is always true"
	^true
]

{ #category : #building }
RSAbstractComponentCalypso >> applyTheme: builder [
	| renderer |
	builder canvas color: self theme backgroundColor.
	renderer := builder renderer.
]

{ #category : #building }
RSAbstractComponentCalypso >> build [

	| canvas |
	canvas := self buildComponentCanvas.
	morph := canvas createMorph.
	morph
		onAnnouncement: MorphDeleted
		do: [
		self containerTab owner ifNotNil: [ self containerTab delete ] ].
	canvas when: RSMouseEnter do: [ morph takeKeyboardFocus ] for: self.
	self addMorph: morph fullFrame: LayoutFrame identity
]

{ #category : #building }
RSAbstractComponentCalypso >> buildComponentCanvas [
	| builder |
	builder := self componentBuilder.
	builder canvas @ self canvasController.
	builder build.
	^ builder canvas
]

{ #category : #building }
RSAbstractComponentCalypso >> canvasController [
	| controls |
	controls := RSCanvasController new.
	controls configuration 
		useBasicZoom;
		maxScale: 2.
	^ controls
]

{ #category : #building }
RSAbstractComponentCalypso >> componentBuilder [
	| builder |
	builder := RSComponentBuilder new.
	builder renderer: RSComponentRenderer new.
	builder container: RSCanvas new.
	builder renderer target: context lastSelectedClass.
	self applyTheme: builder.
	^ builder
]

{ #category : #accessing }
RSAbstractComponentCalypso >> computeClasses [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractComponentCalypso >> defaultIcon [
	self defaultIconName ifNil: [ ^nil ].
	
	^self iconNamed: self defaultIconName
]

{ #category : #building }
RSAbstractComponentCalypso >> defaultIconName [
	^#objects
]
