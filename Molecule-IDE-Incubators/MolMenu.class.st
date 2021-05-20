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
		'component',
		'icon',
		'showComponent'
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

{ #category : #accessing }
MolMenu >> icon [
	"Answer a form with an icon to represent the receiver"
	^ self valueOfProperty: #icon
]

{ #category : #accessing }
MolMenu >> icon: aForm [
	icon := aForm
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

{ #category : #construction }
MolMenu >> newMenuItem [
	^ PluggableMenuItemSpec new
]

{ #category : #protocol }
MolMenu >> open: menu [
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
		add: 'Inspect the Component'
		action: (MessageSend receiver: [  component inspect ]  selector: #value)
		icon: (self iconNamed: 'glamorousInspect').
	menu 	
		addSeparator.
	menu
		add: 'Show the Component'
		action: (MessageSend receiver: [ 
			| usedComponentServices usedComponentParameters consumedComponentEvents providedComponentServices
			providedComponentParameters producedComponentEvents | 
			showComponent := SpMolShowComponent new. 
			component haveComponentType
				ifTrue:[
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
					
					showComponent component: component.
					showComponent openWithSpec
					]
			ifFalse:[
				showComponent component: component.
				showComponent openWithSpec.].
			]  selector: #value)
		icon: (self iconNamed: 'objects').
		
	menu
		add: 'Show all Component Instances'
		action: (MessageSend receiver: [ 
			|componentInstances |
			componentInstances := component allSubInstances.
			
			componentInstances isEmpty 
				ifTrue:[SpMolModalPresenter new openModalWithSpec.]
				ifFalse:[
				showComponent := SpMolShowComponentInstances new. 
				showComponent instances: componentInstances.
				showComponent component: component.
				showComponent openWithSpec].
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

{ #category : #accessing }
MolMenu >> showComponent [
	^showComponent
]
