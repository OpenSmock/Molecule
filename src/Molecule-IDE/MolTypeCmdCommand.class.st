Class {
	#name : #MolTypeCmdCommand,
	#superclass : #MolCmdCommand,
	#instVars : [
		'typeName'
	],
	#category : #'Molecule-IDE-Tools'
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

{ #category : #'as yet unclassified' }
MolTypeCmdCommand >> selectedClass [

	^ selectedItems collect: [ :p | p browserItem actualObject ]
]

{ #category : #'as yet unclassified' }
MolTypeCmdCommand >> selectedTypeClass [
	"this method returns the class selected in the System Browser that is a Type"

	^ self selectedClass select: [ :c | c isComponentType ]
]
