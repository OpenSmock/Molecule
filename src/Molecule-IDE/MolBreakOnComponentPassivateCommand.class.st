Class {
	#name : #MolBreakOnComponentPassivateCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolBreakOnComponentPassivateCommand class >> browserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: MolCmdMenuGroup
		  order: 52
		  for: ClyFullBrowserClassContext
]

{ #category : #accessing }
MolBreakOnComponentPassivateCommand >> defaultMenuIconName [

	^ #halt
]

{ #category : #accessing }
MolBreakOnComponentPassivateCommand >> defaultMenuItemName [

	^ 'Break once on #componentPassivate'
]

{ #category : #accessing }
MolBreakOnComponentPassivateCommand >> description [

	^ 'Add a breakpoint that trigger once when #componentPassivate is call for this specific class.'
]

{ #category : #accessing }
MolBreakOnComponentPassivateCommand >> execute [

	self selectedComponentClasses do: #haltOnComponentPassivate
]
