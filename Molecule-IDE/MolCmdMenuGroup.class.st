"
Class for the menu => right click on a component
"
Class {
	#name : #MolCmdMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #accessing }
MolCmdMenuGroup >> buildContextMenu: aMenu [

	aMenu addLine.
	super buildContextMenu: aMenu
]

{ #category : #accessing }
MolCmdMenuGroup >> description [

	^ 'Molecule component menu'
]

{ #category : #accessing }
MolCmdMenuGroup >> icon [

	^ MolIcon moleculeIcon
]

{ #category : #accessing }
MolCmdMenuGroup >> name [

	^ 'Molecule'
]

{ #category : #accessing }
MolCmdMenuGroup >> order [
	"Idea to put molecule group to the end of menu"

	^ SmallInteger maxVal
]
