"
All the MolViewPortInteraction.
"
Class {
	#name : #MolViewPortInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'port',
		'theme'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #initialization }
MolViewPortInteraction >> applyOn: aPort [
	port := aPort.
	theme := aPort theme.
]

{ #category : #hooks }
MolViewPortInteraction >> onShape: aShape [
	self subclassResponsibility 
]
