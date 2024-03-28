Class {
	#name : #MolOptionsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'implementationList',
		'actionBar',
		'buttonBrowse',
		'buttonClose'
	],
	#category : #'Molecule-IDE-Tools'
}

{ #category : #tests }
MolOptionsPresenter >> buttonBrowse [
	"used for test purposes"

	^ buttonBrowse
]

{ #category : #tests }
MolOptionsPresenter >> buttonBrowseAction [ 
]

{ #category : #tests }
MolOptionsPresenter >> implementationList [
	"used for test purposes"

	^ implementationList
]

{ #category : #tests }
MolOptionsPresenter >> initializePresenters [
	"buttons"

	buttonBrowse := self newButton
		                label: 'Browse';
		                icon: (self iconNamed: #package);
		                help: 'Browse the selected implementation';
		                action: [ self buttonBrowseAction ];
		                disable;
		                yourself.

	buttonClose := self newButton
		               label: 'Close';
		               icon: (self iconNamed: #smallCancel);
		               help: 'Close the window';
		               action: [ self delete ];
		               yourself.
		
"action bar"
	actionBar := self newActionBar
		             addLast: buttonBrowse;
		             addLast: buttonClose;
		             yourself
]

{ #category : #tests }
MolOptionsPresenter >> listImplementations: selectedClass [
	"necessary to use a Collection or one of its subclasses (Array in this case) to retrieve implementations of the selected Type Trait"

	(selectedClass = '' or: selectedClass = OrderedCollection new)
		ifFalse: [
			^ selectedClass users asArray ]
]
