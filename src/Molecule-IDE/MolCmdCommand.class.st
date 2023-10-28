"
super class for menu system browser
"
Class {
	#name : #MolCmdCommand,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedItems',
		'items'
	],
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^self class subclassResponsibility.
]

{ #category : #activation }
MolCmdCommand class >> isAbstract [

	^ self = MolCmdCommand
]

{ #category : #execution }
MolCmdCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	selectedItems := aToolContext selectedItems
]

{ #category : #execution }
MolCmdCommand >> readParametersFromContext: aToolContext [

	super readParametersFromContext: aToolContext
]
