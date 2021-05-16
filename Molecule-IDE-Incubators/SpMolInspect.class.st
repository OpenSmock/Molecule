"
window spec after click on inspect in molActionsMenu
"
Class {
	#name : #SpMolInspect,
	#superclass : #SpPresenter,
	#instVars : [
		'items',
		'table2'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #example }
SpMolInspect class >> defaultSpec [
	^ SpBoxLayout newTopToBottom 
		add: #table2 expand: true
			fill: true padding: 10;
	yourself.
]

{ #category : #initialization }
SpMolInspect >> connectPresenters [
	

	
]

{ #category : #initialization }
SpMolInspect >> initializePresenters [ 
	table2 := self newTreeTable.
	table2 addColumn: (SpCompositeTableColumn new
			title: 'Component';
			addColumn: ((SpImageTableColumn evaluated: #systemIcon)
				width: 20;
				yourself);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself).
	table2 roots: { MolAbstractComponentImpl  }. 
	table2 children:  [ :class | class subclasses ].
	table2 beResizable.
	table2 contextMenu: self menu.
	table2 activateOnDoubleClick.
	table2 whenActivatedDo: [ :selection | selection selectedItem browse ].
	
	
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

{ #category : #api }
SpMolInspect >> menu [
	^ self newMenu
		title: 'Context menu example';
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 
					anItem
						name: 'Print in transcript';
						shortcut: $p meta;
						description: 'Print the selected class on Transcript';
						action: [ table2 selectedItem traceCr ] ] ].
		
]
