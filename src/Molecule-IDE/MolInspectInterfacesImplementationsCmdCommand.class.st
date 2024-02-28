Class {
	#name : #MolInspectInterfacesImplementationsCmdCommand,
	#superclass : #MolInterfaceCmdCommand,
	#category : #'Molecule-IDE-Tools'
}

{ #category : #activation }
MolInspectInterfacesImplementationsCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolInspectInterfacesImplementationsCmdCommand >> defaultMenuIconName [

	^ 'glamorousInspect'
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

	| selectedInterface emptyArray interface |
	selectedInterface := self selectedInterfaceClass.

	interface := MolInterfaces new.
	emptyArray := Array new: 0.

	"condition and ifTrue: are executed only if multiple Traits were/are selected in the System Browser, since this option only supports one Type selected at a time"
	selectedInterface = emptyArray
		ifFalse: [ selectedInterface := selectedInterface at: 1 ]
		ifTrue: [
		selectedInterface := (selectedItems at: 1) browserItem actualObject ].
	interface interface: selectedInterface.
	interface open
]
