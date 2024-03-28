Class {
	#name : #MolInspectTypeImplementationsCmdCommand,
	#superclass : #MolTypeCmdCommand,
	#category : #'Molecule-IDE-Tools'
}

{ #category : #activation }
MolInspectTypeImplementationsCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolInspectTypeImplementationsCmdCommand >> defaultMenuIconName [

	^ 'glamorousInspect'
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

	| selectedType implem emptyArray |
	selectedType := self selectedTypeClass.

	implem := MolImplementations new.
	emptyArray := Array new: 0.

	"condition and ifTrue: are executed only if multiple Traits were/are selected in the System Browser, since this option only supports one Type selected at a time"
	selectedType = emptyArray
		ifFalse: [ selectedType := selectedType at: 1 ]
		ifTrue: [
		selectedType := (selectedItems at: 1) browserItem actualObject ].
	implem type: selectedType.
	implem open
]
