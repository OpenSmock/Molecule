Class {
	#name : #MolImplementationsPresenter,
	#superclass : #MolOptionsPresenter,
	#instVars : [
		'selectedType'
	],
	#category : #'Molecule-IDE-Tools'
}

{ #category : #initialization }
MolImplementationsPresenter >> buttonBrowseAction [
	"an implementation needs to be selected in order to browse it"

	| item |
	item := implementationList selectedItem.

	item ifNotNil: [
		buttonBrowse enable.
		item browse ]
]

{ #category : #initialization }
MolImplementationsPresenter >> connectPresenters [
	"enables the Browse button if an implementation is selected"

	implementationList whenSelectionChangedDo: [
		implementationList selectedItem ifNotNil: [ buttonBrowse enable ] ]
]

{ #category : #initialization }
MolImplementationsPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: implementationList;
		  addLast: actionBar;
		  yourself
]

{ #category : #initialization }
MolImplementationsPresenter >> initializePresenters [

	super initializePresenters.

	implementationList := MolSpFilteringListDoubleClickPresenter new.
	implementationList displayIcon: [ :elem |
		self iconNamed: elem systemIconName ]
]

{ #category : #initialization }
MolImplementationsPresenter >> listImplementations: aComponentType [
	"necessary to use a Collection or one of its subclasses (Array in this case) to retrieve implementations of the selected Type Trait"

	(aComponentType = '' or: aComponentType = OrderedCollection new)
		ifFalse: [
			^ (MolUtils allComponentImplementationClassesOfType: aComponentType) asArray ]
]

{ #category : #initialization }
MolImplementationsPresenter >> title [

	^ selectedType asString , ' Implementations'
]

{ #category : #initialization }
MolImplementationsPresenter >> type: aType [
	"when the Type Trait is given, loads the list"

	"only one Type can be selected in the System Browser at a time"

	selectedType := aType.
	implementationList items: (self listImplementations: selectedType)
]
