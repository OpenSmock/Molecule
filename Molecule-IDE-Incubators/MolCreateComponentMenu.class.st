Class {
	#name : #MolCreateComponentMenu,
	#superclass : #Object,
	#instVars : [
		'label',
		'items',
		'parentMenu',
		'component',
		'icon',
		'showComponent',
		'canvas',
		'componentShape'
	],
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #'instance creation' }
MolCreateComponentMenu class >> withModel: aModel [
	^ self new model: aModel
]

{ #category : #construction }
MolCreateComponentMenu >> add: aString action: aMessageSend icon: aForm [
	| item |
	item := self addMenuItem.
	item label: aString translated.
	item action: aMessageSend.
	item icon: aForm .
	^item
]

{ #category : #construction }
MolCreateComponentMenu >> addMenuItem [
	| item |
	item := self newMenuItem.
	self items add: item.
	^item
]

{ #category : #construction }
MolCreateComponentMenu >> addSeparator [
	self items isEmpty
		ifTrue: [ ^ nil ].
	self items last separator: true
]

{ #category : #accessing }
MolCreateComponentMenu >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #accessing }
MolCreateComponentMenu >> componentShape: aCanvas [
	componentShape := aCanvas
]

{ #category : #accessing }
MolCreateComponentMenu >> icon [
	"Answer a form with an icon to represent the receiver"
	^ self valueOfProperty: #icon
]

{ #category : #accessing }
MolCreateComponentMenu >> icon: aForm [
	icon := aForm
]

{ #category : #accessing }
MolCreateComponentMenu >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
MolCreateComponentMenu >> label [
	^ label
]

{ #category : #accessing }
MolCreateComponentMenu >> label: aString [
	label := aString.
]

{ #category : #construction }
MolCreateComponentMenu >> newMenuItem [
	^ PluggableMenuItemSpec new
]

{ #category : #protocol }
MolCreateComponentMenu >> open: menu [
	menu
		add: 'Create a Component'
		action: (MessageSend receiver: [  
			canvas add: componentShape.
			canvas @RSCanvasController. 
			canvas signalUpdate.
			]  selector: #value)
		icon: MolIcon new icon.
	menu
		add: 'Create a Label'
		action: (MessageSend receiver: 
		[  canvas add: label.
			canvas @ RSCanvasController. 
			canvas signalUpdate. ]  selector: #value)
		icon: (self iconNamed: 'edit').
	menu 	
		addSeparator.
	menu
		add: 'Create Relation'
		action: (MessageSend receiver: [ ]  selector: #value)
		icon: (self iconNamed: 'glamorousInspect').
		
	menu asMenuMorph popUpInWorld
]
