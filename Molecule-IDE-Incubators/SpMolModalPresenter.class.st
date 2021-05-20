"
class to show model presenter if there is no instances of component
"
Class {
	#name : #SpMolModalPresenter,
	#superclass : #SpDemoAbstractModalPresenter,
	#category : #'Molecule-IDE-Incubators'
}

{ #category : #specs }
SpMolModalPresenter class >> title [
	^'Infos'
]

{ #category : #initialization }
SpMolModalPresenter >> content [
	^ 'No instances find for this component'
]

{ #category : #initialization }
SpMolModalPresenter >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog
		closeOnBackdropClick: true;
		okAction: [ :presenter | self inform: 'Ok action' ];
		cancelAction: [ :presenter | self inform: 'Cancel' ]
]
