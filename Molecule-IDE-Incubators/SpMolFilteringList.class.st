Class {
	#name : #SpMolFilteringList,
	#superclass : #SpFilteringListPresenter,
	#category : #'Molecule-IDE-Incubators'
}

{ #category : #specs }
SpMolFilteringList class >> bottomLayout [

	^ SpBoxLayout newTopToBottom
		  add: #listPresenter;
		  add: #filterInputPresenter expand: false;
		  yourself
]

{ #category : #specs }
SpMolFilteringList class >> defaultSpec [

	^ self bottomLayout
]

{ #category : #specs }
SpMolFilteringList class >> topLayout [

	^ SpBoxLayout newTopToBottom
		  add: #filterInputPresenter expand: false;
		  add: #listPresenter;
		  yourself
]

{ #category : #initialization }
SpMolFilteringList >> initializePresenters [

	filterInputPresenter := self newSearchInput 
		placeholder: 'Search...';
		yourself.
	listPresenter := self newListToFilter.
	self matchSubstring
]
