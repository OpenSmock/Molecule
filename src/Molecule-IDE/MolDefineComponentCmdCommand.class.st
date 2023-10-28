Class {
	#name : #MolDefineComponentCmdCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolDefineComponentCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolDefineComponentCmdCommand >> defaultMenuIconName [

	^ 'smallUpdate'
]

{ #category : #accessing }
MolDefineComponentCmdCommand >> defaultMenuItemName [

	^ 'Define'
]

{ #category : #accessing }
MolDefineComponentCmdCommand >> execute [
	| item |
	
	super execute.
	item := items browserItem actualObject.
	MolComponentFactory defineComponent: item
]
