Class {
	#name : #MolBreakOnComponentActivationCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolBreakOnComponentActivationCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolBreakOnComponentActivationCommand >> defaultMenuIconName [

	^ 'halt'
]

{ #category : #accessing }
MolBreakOnComponentActivationCommand >> defaultMenuItemName [

	^ 'Break once on #componentActivate'
]

{ #category : #accessing }
MolBreakOnComponentActivationCommand >> description [

	^ 'Add a breakpoint that trigger once when #componentInitialize is call'
]

{ #category : #accessing }
MolBreakOnComponentActivationCommand >> execute [

	self selectedComponentClasses do: #haltOnComponentActivate
]
