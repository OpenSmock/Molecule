Class {
	#name : #MolMyWarnerOnActivateComponentImpl,
	#superclass : #MolMyWarnerComponentImpl,
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #'life cycle' }
MolMyWarnerOnActivateComponentImpl >> componentActivate [

	super componentActivate.

	self getMolMyStateChangeEventsNotifier operational
]
