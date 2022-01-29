"
window spec after click on inspect in molActionsMenu
"
Class {
	#name : #SpMolInspect,
	#superclass : #SpPresenter,
	#instVars : [
		'items',
		'table'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #layout }
SpMolInspect class >> defaultLayout [
	^ SpBoxLayout newTopToBottom 
		add: #table expand: true
			fill: true padding: 10;
	yourself.
]

{ #category : #initialization }
SpMolInspect >> initializePresenters [ 
	"add table"
	table := self newTreeTable.
	table addColumn: (SpCompositeTableColumn new
			title: 'Component';
			addColumn: ((SpImageTableColumn evaluated: #systemIcon)
				width: 20;
				yourself);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself).
	table roots: { MolAbstractComponentImpl  }. 
	table children:  [ :class | class subclasses ].
	table beResizable.
	table activateOnDoubleClick.
	table whenActivatedDo: [ :selection | selection selectedItem browse ].
	
	
]

{ #category : #initialization }
SpMolInspect >> initializeWindow: aWindowPresenter [

aWindowPresenter
	title: 'inspect Components';
	initialExtent: 1000@700.
			
		
]

{ #category : #accessing }
SpMolInspect >> items [
	^items
]

{ #category : #accessing }
SpMolInspect >> items: anObject [
	items := anObject
]
