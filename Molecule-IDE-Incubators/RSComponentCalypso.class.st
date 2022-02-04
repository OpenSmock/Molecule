"
Class for the component tab in system browser
"
Class {
	#name : #RSComponentCalypso,
	#superclass : #RSAbstractComponentCalypso,
	#instVars : [
		'targetClass'
	],
	#classInstVars : [
		'selectedItems',
		'selected'
	],
	#category : #'Molecule-IDE-Incubators-Tab Calypso'
}

{ #category : #accessing }
RSComponentCalypso class >> classComponentTapActivation [
	<classAnnotation>
	^ ClyTabActivationStrategyAnnotation  for: ClyClass asCalypsoItemContext
]

{ #category : #testing }
RSComponentCalypso class >> shouldBeActivatedInContext: aBrowserContext [
	| list |
	super shouldBeActivatedInContext: aBrowserContext .
	"Subclasses can define extra condition 
	to check that they can be opened in particular browser context instance.
	By default it is always true"
	
	selectedItems := aBrowserContext selectedItems at:1.
	selected := selectedItems browserItem actualObject name.
	
	list := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ 
			        (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
	^list includes: selected asClass.
	
	
]

{ #category : #accessing }
RSComponentCalypso class >> tabOrder [
	^ 300
]

{ #category : #accessing }
RSComponentCalypso >> activationPriority [
	^ -300
]

{ #category : #accessing }
RSComponentCalypso >> buildComponentCanvas [
	| canvas |
	canvas := self targetClass buildUMLCanvasWithBrowserTool: self.
	canvas ifNil: [ canvas := super buildComponentCanvas ].
	^ canvas
]

{ #category : #initialization }
RSComponentCalypso >> defaultTitle [
	^'Graph'
]

{ #category : #initialization }
RSComponentCalypso >> isSimilarTo: anotherBrowserTool [
	(super isSimilarTo: anotherBrowserTool) ifFalse: [ ^false ].
	^ self targetClass = anotherBrowserTool targetClass
]

{ #category : #initialization }
RSComponentCalypso >> setUpModelFromContext [
	self targetClass: context lastSelectedClass.
	
]

{ #category : #accessing }
RSComponentCalypso >> targetClass [
	^targetClass 
]

{ #category : #accessing }
RSComponentCalypso >> targetClass: aTargetClass [
	targetClass := aTargetClass 
]
