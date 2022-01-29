"
Class for the menu => right click on a component
"
Class {
	#name : #CmdMoleculeMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #accessing }
CmdMoleculeMenuGroup >> buildContextMenu: aMenu [
	aMenu addLine.
	
	super buildContextMenu: aMenu
]

{ #category : #accessing }
CmdMoleculeMenuGroup >> description [
	^'Menu for Molecule Component'
]

{ #category : #accessing }
CmdMoleculeMenuGroup >> icon [
	^MolIcon moleculeIcon.
]

{ #category : #accessing }
CmdMoleculeMenuGroup >> name [
	^'Molecule'
]

{ #category : #accessing }
CmdMoleculeMenuGroup >> order [
	"Idea to put molecule group to the end of menu"
	^SmallInteger maxVal
]
