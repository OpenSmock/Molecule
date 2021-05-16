"
window spec after click on molInfoTools
"
Class {
	#name : #SpMolInfoTools,
	#superclass : #SpPresenter,
	#instVars : [
		'table1',
		'initializedPresenters',
		'items',
		'list',
		'table2',
		'table3',
		'table4'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #example }
SpMolInfoTools class >> defaultSpec [
	^ SpBoxLayout newTopToBottom 
		add: #table1 expand: true
			fill: true;
		add: #table4 expand: true
			fill: true;
		add: #table2 expand: true
			fill: true;
		add: #table3 expand: true
			fill: true;
		
	yourself.
]

{ #category : #initialization }
SpMolInfoTools >> connectPresenters [
	

	
]

{ #category : #initialization }
SpMolInfoTools >> initializePresenters [ 
	
	
	table1 := self newTable.
	table1 addColumn: ((SpImageTableColumn title: 'icon' evaluated: #systemIcon) width: 50).
	table1 addColumn: (SpStringTableColumn title: 'name' evaluated: [ list name ]).
	table1 addColumn: (SpStringTableColumn title: 'superclass' evaluated: [ list superclass ]).
	table1 addColumn: (SpStringTableColumn title: 'subclass' evaluated: [ list subclasses ]).
	table1 addColumn: (SpStringTableColumn title: 'category' evaluated: [ list category ]).
	table1 items: {[ list ]}.
	table1 beResizable.
	table1 activateOnDoubleClick.
	table1 whenActivatedDo: [ :selection | selection selectedItem browse ].
	
	table4 := self newTable.
	table4 addColumn: (SpStringTableColumn title: 'size' evaluated: [ list methodDict size ]).
	table4 addColumn: (SpStringTableColumn title: 'methods' evaluated: [ list  methodDict ]).
	table4 items: {[ list ]}.
	table4 beResizable.
	table4 activateOnDoubleClick.
	table4 whenActivatedDo: [ :selection | selection selectedItem browse ].
	
	table2 := self newTreeTable.
	table2 addColumn: (SpCompositeTableColumn new
			title: 'Methods';
			addColumn: ((SpImageTableColumn evaluated: #systemIcon)
				width: 20;
				yourself);
			addColumn: (SpStringTableColumn evaluated: #value);
			yourself).
	table2 addColumn: (SpStringTableColumn evaluated: #value).
	table2 roots: { [list  methodDict ]  }. 
	table2 children:  [ :variable | list  methodDict array].
	table2 beResizable.
	table2 contextMenu: self menu.
	table2 activateOnDoubleClick.
	table2 whenActivatedDo: [ :selection | selection selectedItem browse ].
	
	table3 := self newTree.
	table3 roots: { [list  methodDict]  }. 
	table3 children:  [ :variable | list  methodDict array].
	table3 displayIcon: [ :aClass | aClass systemIcon ].
	table3 display: [ :aClass | aClass value ].
	table3 beResizable.
	table3 contextMenu: self menu.
	table3 activateOnDoubleClick.
	table3 whenActivatedDo: [ :selection | selection selectedItem browse ].
	
	
]

{ #category : #initialization }
SpMolInfoTools >> initializeWindow: aWindowPresenter [

aWindowPresenter
	title: 'Component Details';
	initialExtent: 1000@700.
			
		
]

{ #category : #accessing }
SpMolInfoTools >> items [
	^items
]

{ #category : #accessing }
SpMolInfoTools >> items: anObject [
	items := anObject
]

{ #category : #accessing }
SpMolInfoTools >> list [
	^list
]

{ #category : #accessing }
SpMolInfoTools >> list: aList [
	list := aList
]

{ #category : #api }
SpMolInfoTools >> menu [
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

{ #category : #accessing }
SpMolInfoTools >> table1 [
	^table1
]
