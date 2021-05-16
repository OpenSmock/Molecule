"
Class for calypso for component tab in browser system
"
Class {
	#name : #RSAbstractComponentCalypso,
	#superclass : #ClyBrowserToolMorph,
	#category : #'Molecule-IDE-Incubators-Tab Calypso'
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
	| theme renderer |
	theme := Smalltalk ui theme.
	builder canvas color: theme backgroundColor.
	renderer := builder renderer.
	renderer border color: theme textColor.
	renderer marker shape color: theme backgroundColor.
	renderer textColor: theme textColor.
	renderer boxColor: theme classBoxBackgroundColor.
	builder modelDescriptor methodsLimit: theme methodsLimitUML.
]

{ #category : #building }
RSAbstractComponentCalypso >> build [
	| canvas |
	canvas := self buildComponentCanvas.
	
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
	builder container: RSCanvas new.
	self applyTheme: builder.
	^ builder
]

{ #category : #building }
RSAbstractComponentCalypso >> defaultIconName [
	^#objects
]
