Class {
	#name : #MolInspectInterfacesImplementationsCmdCommand,
	#superclass : #MolInterfaceCmdCommand,
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolInspectInterfacesImplementationsCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolInspectInterfacesImplementationsCmdCommand >> defaultMenuIconName [

	^ #inspect
]

{ #category : #accessing }
MolInspectInterfacesImplementationsCmdCommand >> defaultMenuItemName [

	^ 'See Component users'
]

{ #category : #accessing }
MolInspectInterfacesImplementationsCmdCommand >> description [

	^ 'Shows in a window users of the selected interface (Events, Parameters or Services)'
]

{ #category : #accessing }
MolInspectInterfacesImplementationsCmdCommand >> execute [

	MolInterfacesPresenter new
		interface: self selectedInterfaceClasses first;
		open
]
