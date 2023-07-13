"
super class for menu system browser
"
Class {
	#name : #MolContextualMenu,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedItems',
		'items'
	],
	#classInstVars : [
		'selectedItems',
		'selected'
	],
	#category : #'Molecule-IDE-Incubator-Menus'
}

{ #category : #activation }
MolContextualMenu class >> browserMenuActivation [
	<classAnnotation>
	^self class subclassResponsibility.
]

{ #category : #testing }
MolContextualMenu class >> canBeExecutedInContext: aToolContext [
	| list |
	selectedItems := aToolContext selectedItems at:1.
	selected := selectedItems browserItem actualObject name.
	
	"find all components"
	list := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ 
			        (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
	"return if selected object is in list of component"
	^list includes: selected asClass .
]

{ #category : #accessing }
MolContextualMenu >> defaultMenuIconName [
	^self class subclassResponsibility.
]

{ #category : #accessing }
MolContextualMenu >> defaultMenuItemName [ 
	^self class subclassResponsibility.
]

{ #category : #execution }
MolContextualMenu >> execute [ 
	^items := selectedItems at: 1.
]

{ #category : #execution }
MolContextualMenu >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext. 
	
	selectedItems := aToolContext selectedItems.
]

{ #category : #execution }
MolContextualMenu >> readParametersFromContext: aToolContext [ 
	super readParametersFromContext: aToolContext .
]
