Class {
	#name : #MolInspectComponentRunningInstancesCmdCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolInspectComponentRunningInstancesCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolInspectComponentRunningInstancesCmdCommand >> defaultMenuIconName [

	^ 'glamorousInspect'
]

{ #category : #accessing }
MolInspectComponentRunningInstancesCmdCommand >> defaultMenuItemName [

	^ 'Inspect running components'
]

{ #category : #accessing }
MolInspectComponentRunningInstancesCmdCommand >> description [

	^'Show a list of actually running component instances of this component'
]

{ #category : #accessing }
MolInspectComponentRunningInstancesCmdCommand >> execute [
	| item |
	
	super execute.
	item := items browserItem actualObject.
	
	(MolComponentManager default homeServices deployedComponents at: item ifAbsent:[Dictionary new]) copy inspect
]
