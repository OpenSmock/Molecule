"
Class for Show Component INstances in System Browser
"
Class {
	#name : #MolShowComponentInstancesContextualMenu,
	#superclass : #MolClassesCmdCommand,
	#category : #'Molecule-IDE-Incubator-Menus'
}

{ #category : #activation }
MolShowComponentInstancesContextualMenu class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserClassContext.
	


]

{ #category : #accessing }
MolShowComponentInstancesContextualMenu >> defaultMenuIconName [ 
	^ 'objects'
]

{ #category : #accessing }
MolShowComponentInstancesContextualMenu >> defaultMenuItemName [ 
	^ '[Incubator] Show running instances'
]

{ #category : #execution }
MolShowComponentInstancesContextualMenu >> execute [

	| componentInstances |
	"open instances component window"
	super execute.

	componentInstances := items browserItem actualObject allSubInstances.

	componentInstances isEmpty
		ifTrue: [ SpMolModalComponentInstances new openModal ]
		ifFalse: [ 
			| showComponentInstances |
			showComponentInstances := SpMolShowComponentInstances new.
			showComponentInstances instances: componentInstances.
			showComponentInstances component: items browserItem actualObject.
			showComponentInstances open ]
]
