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
	| componentsToDefine nbOfDefinedComponents |
	
	componentsToDefine := self selectedComponentClasses.
	componentsToDefine do:[ :c | MolComponentFactory defineComponent: c ].
	
	nbOfDefinedComponents := componentsToDefine size.
	self executionResult: nbOfDefinedComponents.
	
	self inform: nbOfDefinedComponents asString, ' component', (nbOfDefinedComponents > 1 ifTrue:['s'] ifFalse:['']) ,' defined'.
]
