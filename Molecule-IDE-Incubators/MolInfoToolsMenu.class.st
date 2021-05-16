"
class for a menu in an extragroup when you right click on a component
"
Class {
	#name : #MolInfoToolsMenu,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedItems',
		'items'
	],
	#classInstVars : [
		'rootGroup',
		'selectedItems',
		'selected',
		'test'
	],
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #activation }
MolInfoToolsMenu class >> browserMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byItemOf: CmdExtraMenuGroup for: ClyFullBrowserClassContext.
	


]

{ #category : #testing }
MolInfoToolsMenu class >> canBeExecutedInContext: aToolContext [
	| list |
	selectedItems := aToolContext selectedItems at:1.
	selected := selectedItems browserItem actualObject name.
	
	list := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ 
			        (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
	^list includes: selected asClass .
	
	
]

{ #category : #execution }
MolInfoToolsMenu >> applyResultInContext: aToolContext [

]

{ #category : #accessing }
MolInfoToolsMenu >> defaultMenuIconName [ 
	^ 'smallInfo'
]

{ #category : #accessing }
MolInfoToolsMenu >> defaultMenuItemName [ 
	^ 'Info Tools Component'
]

{ #category : #execution }
MolInfoToolsMenu >> execute [
	| spInfo |
	spInfo := SpMolInfoTools new.
	
	items := selectedItems at: 1.
	spInfo list: items browserItem actualObject.
	
	spInfo openWithSpec.
]

{ #category : #execution }
MolInfoToolsMenu >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext. 
	
	selectedItems := aToolContext selectedItems.
]

{ #category : #execution }
MolInfoToolsMenu >> readParametersFromContext: aToolContext [ 
	super readParametersFromContext: aToolContext .
	
]
