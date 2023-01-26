"
window spec after click on inspect in molActionsMenu
"
Class {
	#name : #MolSpBrowseComponentClasses,
	#superclass : #SpPresenter,
	#instVars : [
		'items',
		'table'
	],
	#category : #'Molecule-IDE-Spec2'
}

{ #category : #layout }
MolSpBrowseComponentClasses class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #table
		  expand: true
		  fill: true
		  padding: 10;
		  yourself
]

{ #category : #initialization }
MolSpBrowseComponentClasses >> initializePresenters [ 
	"add table"
	table := self newTreeTable.
	table addColumn: (SpCompositeTableColumn new
			title: 'Double click on a class to browse it...';
			addColumn: ((SpImageTableColumn evaluated: [ :e | e iconNamed: e systemIconName])
				width: 20;
				yourself);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself).
	table roots: { MolAbstractComponentImpl . MolComponentImpl }. 
	table children:  [ :e | | users |
		e = MolAbstractComponentImpl ifTrue:[ 
			e subclasses 
		] ifFalse:[ 
			users := e users copy asOrderedCollection.
			users remove: MolAbstractComponentImpl ifAbsent: [nil].
			users
		].
	].
	table beResizable.
	table beSingleSelection.
	table activateOnDoubleClick.
	table whenActivatedDo: [ :selection | selection selectedItem browse ].
	
	
]

{ #category : #initialization }
MolSpBrowseComponentClasses >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Browse all Molecule component classes';
		initialExtent: 500 @ 500;
		windowIcon: MolIcon moleculeIcon.
]

{ #category : #accessing }
MolSpBrowseComponentClasses >> items [

	^ items
]

{ #category : #accessing }
MolSpBrowseComponentClasses >> items: anObject [

	items := anObject
]
