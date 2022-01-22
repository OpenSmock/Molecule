"
Class for Show Component INstances in System Browser
"
Class {
	#name : #MolShowComponentInstancesContextualMenu,
	#superclass : #MolContextualMenu,
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #activation }
MolShowComponentInstancesContextualMenu class >> browserMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byItemOf: CmdMoleculeMenuGroup for: ClyFullBrowserClassContext.
	


]

{ #category : #accessing }
MolShowComponentInstancesContextualMenu >> defaultMenuIconName [ 
	^ 'objects'
]

{ #category : #accessing }
MolShowComponentInstancesContextualMenu >> defaultMenuItemName [ 
	^ 'Show running instances'
]

{ #category : #execution }
MolShowComponentInstancesContextualMenu >> execute [
	| componentInstances |
	"open instances component window"
	super execute.
	
	componentInstances := items browserItem actualObject allSubInstances.
			
	componentInstances isEmpty 
		ifTrue:[SpMolModalComponentInstances new openModalWithSpec.]
		ifFalse:
		[ |showComponentInstances|
				showComponentInstances := SpMolShowComponentInstances new. 
				showComponentInstances instances: componentInstances.
				showComponentInstances component: items browserItem actualObject.
				showComponentInstances openWithSpec.
			]
]
