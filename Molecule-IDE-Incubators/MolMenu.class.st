"
class for menu when you right click on a component
"
Class {
	#name : #MolMenu,
	#superclass : #Object,
	#instVars : [
		'label',
		'items',
		'parentMenu',
		'component'
	],
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #'instance creation' }
MolMenu class >> withModel: aModel [
	^ self new model: aModel
]

{ #category : #construction }
MolMenu >> add: aString action: aMessageSend icon: aForm [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	item icon: aForm .
	^item
]

{ #category : #construction }
MolMenu >> addMenuItem [
	| item |
	item := self newMenuItem.
	self items add: item.
	^item
]

{ #category : #construction }
MolMenu >> addSeparator [
	self items isEmpty
		ifTrue: [ ^ nil ].
	self items last separator: true
]

{ #category : #converting }
MolMenu >> asMenuMorph [
	^ self asMenuMorphOfKind: self morphClass
]

{ #category : #converting }
MolMenu >> asMenuMorphOfKind: aMorphClass [
	| prior menu myitems |
	prior := parentMenu.
	parentMenu := menu := aMorphClass new.
	myitems := self items.
	myitems do: [ :each | each asMenuItemMorphFrom: parentMenu isLast: each = myitems last ].
	parentMenu := prior.
	^ menu
]

{ #category : #accessing }
MolMenu >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
MolMenu >> label [
	^ label
]

{ #category : #accessing }
MolMenu >> label: aString [
	label := aString.
]

{ #category : #factory }
MolMenu >> morphClass [
	^ MenuMorph
]

{ #category : #construction }
MolMenu >> newMenuItem [
	^ PluggableMenuItemSpec new
]

{ #category : #protocol }
MolMenu >> open: menu [

	" menu when right click on a component"

	menu
		add: 'System Browser'
		action: (MessageSend receiver: [  component browse ]  selector: #value)
		icon: (self iconNamed: 'nautilus').
	menu
		add: 'Info Tools Component'
		action: (MessageSend receiver: 
		[  | spInfo |
			spInfo := SpMolInfoTools new.
			spInfo list: component.
			spInfo openWithSpec. ]  selector: #value)
		icon: (self iconNamed: 'smallInfo').
	menu
		add: 'Inspect the Class'
		action: (MessageSend receiver: [  component inspect ]  selector: #value)
		icon: (self iconNamed: 'glamorousInspect').
	menu 	
		addSeparator.
	menu
		add: 'Show the Component'
		action: (MessageSend receiver: [ 
			| usedComponentServices usedComponentParameters consumedComponentEvents providedComponentServices
			providedComponentParameters producedComponentEvents showComponent | 
			showComponent := SpMolShowComponent new. 
			component haveComponentType
				ifTrue:[
					
					"find and add component connected to the component by interfaces"
					
					usedComponentServices := OrderedCollection new.
					component usedComponentServices do: [:compo| compo users 
						do: [:comp | comp == component ifFalse: [ usedComponentServices add: comp ] ]].
			
					usedComponentParameters := OrderedCollection new.
					component usedComponentParameters do: [:compo| compo users 
					do: [:comp | comp == component ifFalse: [ usedComponentParameters add: comp]]].
			
					consumedComponentEvents := OrderedCollection new.
					component consumedComponentEvents do: [:compo| compo users
				 	do: [:comp | comp == component ifFalse: [ consumedComponentEvents add: comp]]].
			
					providedComponentServices := OrderedCollection new.
					component providedComponentServices do: [:compo| compo users 
					do: [:comp | comp == component ifFalse: [ providedComponentServices add: comp] ]].
			
					providedComponentParameters := OrderedCollection new.
					component providedComponentParameters do: [:compo| compo users 
					do: [:comp | comp == component ifFalse: [ providedComponentParameters add: comp]]].
			
					producedComponentEvents := OrderedCollection new.
					component producedComponentEvents do: [:compo| compo users 
					do: [:comp | comp == component ifFalse: [ producedComponentEvents add: comp]]].
			
					showComponent usedComponentServicesConnected: usedComponentServices.
					showComponent usedComponentParametersConnected: usedComponentParameters.
					showComponent providedComponentServicesConnected: providedComponentServices.
					showComponent providedComponentParametersConnected: providedComponentParameters.
					showComponent producedComponentEventsConnected: producedComponentEvents.
					showComponent consumedComponentEventsConnected: consumedComponentEvents.
					].
				showComponent component: component.
				showComponent openWithSpec.
			]  selector: #value)
		icon: (self iconNamed: 'objects').
		
	menu
		add: 'Show all Component Instances'
		action: (MessageSend receiver: [ 
			"find instances of component"
			|componentInstances |
			componentInstances := component allSubInstances.
			
			componentInstances isEmpty 
				ifTrue:[ SpMolModalComponentInstances new openModalWithSpec. ]
				ifFalse:[
					|showComponentInstances|
					showComponentInstances := SpMolShowComponentInstances new. 
					showComponentInstances instances: componentInstances.
					showComponentInstances component: component.
					showComponentInstances openWithSpec ].
			]  selector: #value)
		icon: (self iconNamed: 'objects').
		
	menu
		add: 'Show UML Class'
		action: (MessageSend receiver: 
		[  | builder |
			builder := RSUMLClassBuilder new.
			builder classes: {component}.
			builder build.
			builder canvas open ]  selector: #value)
		icon: (self iconNamed: 'hierarchy').
		
	menu asMenuMorph popUpInWorld
]

{ #category : #'as yet unclassified' }
MolMenu >> selectedComponent [
	^component 
]

{ #category : #'as yet unclassified' }
MolMenu >> selectedComponent: anObject [
	component := anObject
]
