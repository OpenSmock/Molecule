Class {
	#name : #MolInterfaceCmdCommand,
	#superclass : #MolCmdCommand,
	#category : #'Molecule-IDE-Tools'
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

{ #category : #'api - accessing' }
MolInterfaceCmdCommand >> selectedClass [

	^ (selectedItems collect: [ :p | p browserItem actualObject ])
]

{ #category : #'as yet unclassified' }
MolInterfaceCmdCommand >> selectedInterfaceClass [
	"this method returns the class in the System Browser that is an interface (Events/Parameters/Services)"

	^ self selectedClass select: [ :c |
		  c isComponentEvents or:
			  (c isComponentParameters or: c isComponentServices) ]
]
