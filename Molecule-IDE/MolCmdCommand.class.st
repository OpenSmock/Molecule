"
super class for menu system browser
"
Class {
	#name : #MolCmdCommand,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedItems',
		'items'
	],
	#classInstVars : [
		'selectedItems',
		'selected'
	],
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^self class subclassResponsibility.
]

{ #category : #testing }
MolCmdCommand class >> canBeExecutedInContext: aToolContext [
	| list |
	aToolContext selectedItems isEmpty ifTrue:[^false].
	
	selectedItems := aToolContext selectedItems at:1.
	selected := selectedItems browserItem actualObject name.
	
	"find all components"
	list := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ 
			        (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
	"return if selected object is in list of component"
	^list includes: (self class environment at: selected asSymbol) .
]

{ #category : #accessing }
MolCmdCommand >> defaultMenuIconName [

	^ self class subclassResponsibility
]

{ #category : #accessing }
MolCmdCommand >> defaultMenuItemName [

	^ self class subclassResponsibility
]

{ #category : #execution }
MolCmdCommand >> execute [

	^ items := selectedItems at: 1
]

{ #category : #execution }
MolCmdCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	selectedItems := aToolContext selectedItems
]

{ #category : #execution }
MolCmdCommand >> readParametersFromContext: aToolContext [

	super readParametersFromContext: aToolContext
]
