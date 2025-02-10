Class {
	#name : #MolBreakOnComponentInitializeCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolBreakOnComponentInitializeCommand class >> browserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: MolCmdMenuGroup
		  order: 50
		  for: ClyFullBrowserClassContext
]

{ #category : #accessing }
MolBreakOnComponentInitializeCommand >> defaultMenuIconName [

	^ #halt
]

{ #category : #accessing }
MolBreakOnComponentInitializeCommand >> defaultMenuItemName [

	^ 'Break once when state switch to #initialize'
]

{ #category : #accessing }
MolBreakOnComponentInitializeCommand >> description [

	^ 'Add a breakpoint that trigger once when #componentInitialize is call for any instances of this specific class.'
]

{ #category : #accessing }
MolBreakOnComponentInitializeCommand >> execute [

	self selectedComponentClasses do: #breakOnceOnComponentInitialize
]
