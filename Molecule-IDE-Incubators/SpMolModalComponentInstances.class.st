"
class to show model presenter if there is no instances of component
"
Class {
	#name : #SpMolModalComponentInstances,
	#superclass : #SpDemoAbstractModalPresenter,
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #specs }
SpMolModalComponentInstances class >> title [
	^'Infos'
]

{ #category : #initialization }
SpMolModalComponentInstances >> content [
	^ 'No instances find for this component'
]

{ #category : #initialization }
SpMolModalComponentInstances >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog
		closeOnBackdropClick: true;
		okAction: [ :presenter | self inform: 'Ok action' ];
		cancelAction: [ :presenter | self inform: 'Cancel' ]
]
