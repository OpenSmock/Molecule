Class {
	#name : #MolBreakOnComponentInitializationCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolBreakOnComponentInitializationCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolBreakOnComponentInitializationCommand >> defaultMenuIconName [

	^ 'halt'
]

{ #category : #accessing }
MolBreakOnComponentInitializationCommand >> defaultMenuItemName [

	^ 'Break once on #componentInitialize'
]

{ #category : #accessing }
MolBreakOnComponentInitializationCommand >> description [

	^ 'Add a breakpoint that trigger once when #componentInitialize is call'
]

{ #category : #accessing }
MolBreakOnComponentInitializationCommand >> execute [

	self selectedComponentClasses haltOnComponentInitialize
]
