"
Class for the menu to create a component
"
Class {
	#name : #MolCreateComponentMenu,
	#superclass : #MolMenu,
	#instVars : [
		'canvas',
		'componentShape'
	],
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #accessing }
MolCreateComponentMenu >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #accessing }
MolCreateComponentMenu >> componentShape: aCanvas [
	componentShape := aCanvas
]

{ #category : #protocol }
MolCreateComponentMenu >> open: menu [

	"menu in a canvas in a create Component window"

	menu
		add: 'Create a Component'
		action: (MessageSend receiver: 
		[  
			canvas add: componentShape.
			canvas @ RSCanvasController. 
			canvas signalUpdate.
			]  
		selector: #value)
		icon: MolIcon new icon.
		
	menu
		add: 'Create a Label'
		action: (MessageSend receiver: 
		[  
			canvas add: label.
			canvas @ RSCanvasController. 
			canvas signalUpdate. 
			]  
		selector: #value)
		icon: (self iconNamed: 'edit').
	menu 	
		addSeparator.
	menu
		add: 'Create Relation'
		action: (MessageSend receiver: [ ]  selector: #value)
		icon: (self iconNamed: 'glamorousInspect').
		
	menu asMenuMorph popUpInWorld
]
