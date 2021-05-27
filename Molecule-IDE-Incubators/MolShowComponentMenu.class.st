"
Menu to access on the component graphic vue
"
Class {
	#name : #MolShowComponentMenu,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedItems',
		'items'
	],
	#classInstVars : [
		'rootGroup',
		'selectedItems',
		'selected',
		'test'
	],
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #activation }
MolShowComponentMenu class >> browserMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byItemOf: CmdExtraMenuGroup for: ClyFullBrowserClassContext.
	


]

{ #category : #testing }
MolShowComponentMenu class >> canBeExecutedInContext: aToolContext [
	| list |
	selectedItems := aToolContext selectedItems at:1.
	selected := selectedItems browserItem actualObject name.
	
	list := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ 
			        (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
	^list includes: selected asClass .
	
	
]

{ #category : #execution }
MolShowComponentMenu >> applyResultInContext: aToolContext [

]

{ #category : #accessing }
MolShowComponentMenu >> defaultMenuIconName [ 
	^ 'objects'
]

{ #category : #accessing }
MolShowComponentMenu >> defaultMenuItemName [ 
	^ 'Show the Component'
]

{ #category : #execution }
MolShowComponentMenu >> execute [
	| spInfo usedComponentServices usedComponentParameters consumedComponentEvents providedComponentServices
			providedComponentParameters producedComponentEvents showComponent |
	spInfo := SpMolInfoTools new.
	
	items := selectedItems at: 1.
	spInfo list: items browserItem actualObject.
	
			showComponent := SpMolShowComponent new. 
			items browserItem actualObject haveComponentType
				ifTrue:[
					usedComponentServices := OrderedCollection new.
					items browserItem actualObject usedComponentServices do: [:compo| compo users 
						do: [:comp | comp == items browserItem actualObject ifFalse: [ usedComponentServices add: comp ] ]].
			
					usedComponentParameters := OrderedCollection new.
					items browserItem actualObject usedComponentParameters do: [:compo| compo users 
					do: [:comp | comp == items browserItem actualObject ifFalse: [ usedComponentParameters add: comp]]].
			
					consumedComponentEvents := OrderedCollection new.
					items browserItem actualObject consumedComponentEvents do: [:compo| compo users
				 	do: [:comp | comp == items browserItem actualObject ifFalse: [ consumedComponentEvents add: comp]]].
			
					providedComponentServices := OrderedCollection new.
					items browserItem actualObject providedComponentServices do: [:compo| compo users 
					do: [:comp | comp == items browserItem actualObject ifFalse: [ providedComponentServices add: comp] ]].
			
					providedComponentParameters := OrderedCollection new.
					items browserItem actualObject providedComponentParameters do: [:compo| compo users 
					do: [:comp | comp == items browserItem actualObject ifFalse: [ providedComponentParameters add: comp]]].
			
					producedComponentEvents := OrderedCollection new.
					items browserItem actualObject producedComponentEvents do: [:compo| compo users 
					do: [:comp | comp == items browserItem actualObject ifFalse: [ producedComponentEvents add: comp]]].
			
					showComponent usedComponentServicesConnected: usedComponentServices.
					showComponent usedComponentParametersConnected: usedComponentParameters.
					showComponent providedComponentServicesConnected: providedComponentServices.
					showComponent providedComponentParametersConnected: providedComponentParameters.
					showComponent producedComponentEventsConnected: producedComponentEvents.
					showComponent consumedComponentEventsConnected: consumedComponentEvents.
					
					showComponent component: items browserItem actualObject.
					showComponent openWithSpec
					]
			ifFalse:[
				showComponent component: items browserItem actualObject.
				showComponent openWithSpec.]
]

{ #category : #execution }
MolShowComponentMenu >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext. 
	
	selectedItems := aToolContext selectedItems.
]

{ #category : #execution }
MolShowComponentMenu >> readParametersFromContext: aToolContext [ 
	super readParametersFromContext: aToolContext .
	
]
