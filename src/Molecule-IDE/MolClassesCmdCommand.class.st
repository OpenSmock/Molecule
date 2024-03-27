Class {
	#name : #MolClassesCmdCommand,
	#superclass : #MolCmdCommand,
	#category : #'Molecule-IDE'
}

{ #category : #testing }
MolClassesCmdCommand class >> canBeExecutedInContext: aToolContext [
	| list selectedItem selected |
	
	(super canBeExecutedInContext: aToolContext) ifFalse:[ ^ false ].
	aToolContext selectedItems ifEmpty:[ ^ false ].
	 
	selectedItem := aToolContext selectedItems at: 1.
	selected := selectedItem browserItem actualObject name.
	
	"find all components"
	list := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ 
			        (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
	
	"return if selected object is in list of component"
	^list includes: (self class environment at: selected asSymbol) .
]

{ #category : #testing }
MolClassesCmdCommand class >> isAbstract [

	^ self = MolClassesCmdCommand
]

{ #category : #execution }
MolClassesCmdCommand >> selectedClasses [

	^ selectedItems collect:[ :p | p browserItem actualObject ]
]

{ #category : #execution }
MolClassesCmdCommand >> selectedComponentClasses [

	^ self selectedClasses select:[ :c | c isComponentClass ].
]
