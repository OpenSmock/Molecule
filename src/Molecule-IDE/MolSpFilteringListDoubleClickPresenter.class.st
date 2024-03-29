Class {
	#name : #MolSpFilteringListDoubleClickPresenter,
	#superclass : #SpFilteringListPresenter,
	#category : #'Molecule-IDE-Tools'
}

{ #category : #simulation }
MolSpFilteringListDoubleClickPresenter >> connectPresenters [

	super connectPresenters.
	self doubleClickActivated
]

{ #category : #simulation }
MolSpFilteringListDoubleClickPresenter >> doubleClickActivated [
	"activates the Browse functionality by double-clicking an element"

	| item |
	listPresenter whenActivatedDo: [
		item := listPresenter selectedItem.
		item browse ]
]

{ #category : #simulation }
MolSpFilteringListDoubleClickPresenter >> initializePresenters [
	"changes the original 'Filter...' placeholder text to 'Hit return to accept'"

	super initializePresenters.
	filterInputPresenter placeholder: 'Hit return to accept'
]
