Class {
	#name : #MolDefineComponentCmdCommand,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolDefineComponentCmdCommand class >> browserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: MolCmdMenuGroup
		  order: 10
		  for: ClyFullBrowserClassContext
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

{ #category : #execution }
MolDefineComponentCmdCommand >> execute [

	| componentsToDefine nbOfDefinedComponents text |
	componentsToDefine := self selectedComponentClasses.
	componentsToDefine do: [ :c | MolComponentFactory defineComponent: c ].

	nbOfDefinedComponents := componentsToDefine size.

	text := nbOfDefinedComponents = 1
		        ifTrue: [
		        'Define component: ' , componentsToDefine first printString ]
		        ifFalse: [
			        nbOfDefinedComponents asString , ' component'
			        , (nbOfDefinedComponents > 1
					         ifTrue: [ 's' ]
					         ifFalse: [ '' ]) , ' defined' ].

	MolUtils showInformation: text
]
