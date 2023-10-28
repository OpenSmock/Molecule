Class {
	#name : #MolDefineComponentCmdCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolDefineComponentCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
]

{ #category : #accessing }
MolDefineComponentCmdCommand >> defaultMenuIconName [

	^ 'smallUpdate'
]

{ #category : #accessing }
MolDefineComponentCmdCommand >> defaultMenuItemName [

	^ 'Define'
]

{ #category : #accessing }
MolDefineComponentCmdCommand >> description [

	^'Define this component: force to generate methods from contract definition'
]

{ #category : #accessing }
MolDefineComponentCmdCommand >> execute [
	| componentsToDefine nbComponents |
	
	componentsToDefine := self selectedClasses select:[ :c | c isComponentClass ].
	componentsToDefine do:[ :c | MolComponentFactory defineComponent: c ].
	
	nbComponents := componentsToDefine size.
	
	self inform: nbComponents asString, ' component', (nbComponents > 1 ifTrue:['s'] ifFalse:['']) ,' defined'.
]
