"
Menu to access on the component graphic vue
"
Class {
	#name : #MolShowComponentContextualMenu,
	#superclass : #MolContextualMenu,
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #activation }
MolShowComponentContextualMenu class >> browserMenuActivation [
	<classAnnotation>
	^CmdContextMenuActivation byItemOf: CmdMoleculeMenuGroup for: ClyFullBrowserClassContext.
	


]

{ #category : #accessing }
MolShowComponentContextualMenu >> defaultMenuIconName [ 
	^'objects'
]

{ #category : #accessing }
MolShowComponentContextualMenu >> defaultMenuItemName [ 
	^ 'Show Component map'
]

{ #category : #execution }
MolShowComponentContextualMenu >> execute [
	| item usedComponentServices usedComponentParameters consumedComponentEvents providedComponentServices
			providedComponentParameters producedComponentEvents showComponent |
	
	"open show component window"
	
	super execute.
	
	item := items browserItem actualObject.
	
			showComponent := SpMolShowComponent new. 
			item haveComponentType
				ifTrue:[
					usedComponentServices := OrderedCollection new.
					items browserItem actualObject usedComponentServices do: [:compo| compo users 
						do: [:comp | comp == item ifFalse: [ usedComponentServices add: comp ] ]].
			
					usedComponentParameters := OrderedCollection new.
					item usedComponentParameters do: [:compo| compo users 
					do: [:comp | comp == item ifFalse: [ usedComponentParameters add: comp]]].
			
					consumedComponentEvents := OrderedCollection new.
					item consumedComponentEvents do: [:compo| compo users
				 	do: [:comp | comp == item ifFalse: [ consumedComponentEvents add: comp]]].
			
					providedComponentServices := OrderedCollection new.
					item providedComponentServices do: [:compo| compo users 
					do: [:comp | comp == item ifFalse: [ providedComponentServices add: comp] ]].
			
					providedComponentParameters := OrderedCollection new.
					item providedComponentParameters do: [:compo| compo users 
					do: [:comp | comp == item ifFalse: [ providedComponentParameters add: comp]]].
			
					producedComponentEvents := OrderedCollection new.
					item producedComponentEvents do: [:compo| compo users 
					do: [:comp | comp == item ifFalse: [ producedComponentEvents add: comp]]].
			
					showComponent usedComponentServicesConnected: usedComponentServices.
					showComponent usedComponentParametersConnected: usedComponentParameters.
					showComponent providedComponentServicesConnected: providedComponentServices.
					showComponent providedComponentParametersConnected: providedComponentParameters.
					showComponent producedComponentEventsConnected: producedComponentEvents.
					showComponent consumedComponentEventsConnected: consumedComponentEvents.
					].
			
				showComponent component: item.
				showComponent openWithSpec.
]
