Class {
	#name : #MolInterfaceCmdCommand,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedInterfaceClasses'
	],
	#category : #'Molecule-IDE-Commands'
}

{ #category : #testing }
MolInterfaceCmdCommand class >> canBeExecutedInContext: aToolContext [

	| list selectedItem selected |
	(super canBeExecutedInContext: aToolContext) ifFalse: [ ^ false ].
	aToolContext selectedItems ifEmpty: [ ^ false ].

	selectedItem := aToolContext selectedItems at: 1.
	selected := selectedItem browserItem actualObject name.

	"find all interfaces"
	list := SystemNavigation default allClasses select: [ :c |
		        c isTrait and: [
			        c isComponentEvents or:
				        (c isComponentParameters or: c isComponentServices) ] ].

	"return if selected object is in list of component"
	^ list includes: (self class environment at: selected asSymbol)
]

{ #category : #execution }
MolInterfaceCmdCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	selectedInterfaceClasses := aToolContext selectedItems
		                            collect: [ :p |
		                            p browserItem actualObject ]
		                            thenSelect: [ :c |
			c isTrait and: [ 
			                            c isComponentEvents or: [
				                            c isComponentParameters or: [
					                            c isComponentServices ] ] ] ]
]

{ #category : #'as yet unclassified' }
MolInterfaceCmdCommand >> selectedInterfaceClasses [
	^ selectedInterfaceClasses
]
