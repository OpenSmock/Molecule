Class {
	#name : #MolInspectTypeImplementationsCmdCommand,
	#superclass : #MolTypeCmdCommand,
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolInspectTypeImplementationsCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolInspectTypeImplementationsCmdCommand >> defaultMenuIconName [

	^ #inspect
]

{ #category : #accessing }
MolInspectTypeImplementationsCmdCommand >> defaultMenuItemName [

	^ 'See Component Implementations'
]

{ #category : #accessing }
MolInspectTypeImplementationsCmdCommand >> description [

	^ 'Shows implementations of this Molecule Type'
]

{ #category : #accessing }
MolInspectTypeImplementationsCmdCommand >> execute [

	MolImplementationsPresenter new
		type: self selectedTypeClass first;
		open
]
