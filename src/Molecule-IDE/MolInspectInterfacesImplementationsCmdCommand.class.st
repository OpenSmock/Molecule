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

	^ #references
]

{ #category : #accessing }
MolInspectInterfacesImplementationsCmdCommand >> defaultMenuItemName [

	| contractType |
	self selectedInterfaceClasses ifNil: [ ^ 'nothing' ].
	self selectedInterfaceClasses ifEmpty: [ ^ 'nothing' ].
	contractType := 'Unknow contract'.
	(self selectedInterfaceClasses first usesTrait: MolComponentEvents)
		ifTrue: [ contractType := 'Events' ].
	(self selectedInterfaceClasses first usesTrait: MolComponentServices)
		ifTrue: [ contractType := 'Services' ].
	(self selectedInterfaceClasses first usesTrait: MolComponentParameters)
		ifTrue: [ contractType := 'Parameters' ].
	^ 'See Component Types that uses this <1s>' expandMacrosWith:
		  contractType
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
