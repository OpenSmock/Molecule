Class {
	#name : #MolBreakOnComponentActivateCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolBreakOnComponentActivateCommand class >> browserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: MolCmdMenuGroup
		  order: 51
		  for: ClyFullBrowserClassContext
]

{ #category : #accessing }
MolBreakOnComponentActivateCommand >> defaultMenuIconName [

	^ #halt
]

{ #category : #accessing }
MolBreakOnComponentActivateCommand >> defaultMenuItemName [

	^ 'Break once on #componentActivate'
]

{ #category : #accessing }
MolBreakOnComponentActivateCommand >> description [

	^ 'Add a breakpoint that trigger once when #componentActivate is call for this specific class.'
]

{ #category : #accessing }
MolBreakOnComponentActivateCommand >> execute [

	self selectedComponentClasses do: #haltOnComponentActivate
]
