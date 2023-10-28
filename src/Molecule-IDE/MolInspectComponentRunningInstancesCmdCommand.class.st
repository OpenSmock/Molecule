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
	| selectedComponents instanceList |

	selectedComponents := self selectedComponentClasses. 
	instanceList := Set new.

	selectedComponents do:[ :c | | running |
		running := (MolComponentManager default homeServices deployedComponents at: c ifAbsent:[ Dictionary new ]) copy.
		running isEmpty ifFalse:[ instanceList add: running ].			
	].
	
	^ instanceList inspect
]
