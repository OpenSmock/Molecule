"
All the MolViewPortInteraction.
"
Class {
	#name : #MolViewPortInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'port'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #initialization }
MolViewPortInteraction >> applyOn: aPort [
	port := aPort.
]

{ #category : #hooks }
MolViewPortInteraction >> onShape: aShape [
	self subclassResponsibility 
]
