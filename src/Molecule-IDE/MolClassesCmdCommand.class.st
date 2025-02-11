Class {
	#name : #MolClassesCmdCommand,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedComponentClasses'
	],
	#category : #'Molecule-IDE-Commands'
}

{ #category : #testing }
MolClassesCmdCommand class >> canBeExecutedInContext: aToolContext [

	(super canBeExecutedInContext: aToolContext) ifFalse: [ ^ false ].
	aToolContext selectedItems ifEmpty: [ ^ false ].
	^ aToolContext selectedItems first actualObject isComponentClass.

]

{ #category : #testing }
MolClassesCmdCommand class >> isAbstract [

	^ self = MolClassesCmdCommand
]

{ #category : #execution }
MolClassesCmdCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	selectedComponentClasses := aToolContext selectedItems collect: [ :p | p browserItem actualObject ] thenSelect: #isComponentClass
]

{ #category : #execution }
MolClassesCmdCommand >> selectedComponentClasses [

	^ selectedComponentClasses
]
