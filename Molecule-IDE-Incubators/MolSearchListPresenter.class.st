"
class to define the filter of the list
"
Class {
	#name : #MolSearchListPresenter,
	#superclass : #SpFilteringListPresenter,
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #specs }
MolSearchListPresenter class >> bottomLayout [

	^ SpBoxLayout newTopToBottom
		  add: #listPresenter;
		  add: #filterInputPresenter expand: false;
		  yourself
]

{ #category : #specs }
MolSearchListPresenter class >> defaultLayout [

	^ self bottomLayout
]

{ #category : #specs }
MolSearchListPresenter class >> topLayout [

	^ SpBoxLayout newTopToBottom
		  add: #filterInputPresenter expand: false;
		  add: #listPresenter;
		  yourself
]

{ #category : #initialization }
MolSearchListPresenter >> initializePresenters [

	super initializePresenters.

	filterInputPresenter := self newSearchInput placeholder: 'Search...'; yourself.
	listPresenter := self newListToFilter.
	self matchSubstring
]
