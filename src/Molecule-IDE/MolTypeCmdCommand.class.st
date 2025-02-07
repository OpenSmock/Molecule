Class {
	#name : #MolTypeCmdCommand,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedTypeClass'
	],
	#category : #'Molecule-IDE-Commands'
}

{ #category : #testing }
MolTypeCmdCommand class >> canBeExecutedInContext: aToolContext [

	| list selectedItem selected |
	(super canBeExecutedInContext: aToolContext) ifFalse: [ ^ false ].
	aToolContext selectedItems ifEmpty: [ ^ false ].

	selectedItem := aToolContext selectedItems at: 1.
	selected := selectedItem browserItem actualObject name.

	"find all Types"
	list := SystemNavigation default allClasses select: [ :c |
		        c isTrait and: [ c isComponentType ] ].

	"return if selected object is in list of component"
	^ list includes: (self class environment at: selected asSymbol)
]

{ #category : #execution }
MolTypeCmdCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	selectedTypeClass := aToolContext selectedItems
		                 collect: [ :item | item browserItem actualObject ]
		                 thenSelect: [ :each | each isTrait and: [ each isComponentType ]]
]

{ #category : #'as yet unclassified' }
MolTypeCmdCommand >> selectedTypeClass [
	"this method returns the class selected in the System Browser that is a Type"

	^ selectedTypeClass
]
