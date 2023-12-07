Class {
	#name : #MolPackagesCmdCommand,
	#superclass : #MolCmdCommand,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #activation }
MolPackagesCmdCommand class >> canBeExecutedInContext: aToolContext [
	"Open only if the package contains Molecule entities"

	| items |
	(super canBeExecutedInContext: aToolContext) ifFalse: [ ^ false ].
	aToolContext selectedItems ifEmpty: [ ^ false ].

	items := aToolContext selectedItems collect: [ :e |
		         e browserItem actualObject ].

	"return true if the selected packages contains Molecule components elements (Contracts, Components, etc.)"
	^ items anySatisfy: [ :p |
		  | found |
		  found := p classes
			           detect: [ :c |
				           c isComponentClass or: [
					           c isTrait and: [
						           c isComponentType or: [
							           c isComponentServices or: [
								           c isComponentEvents or: [ c isComponentParameters ] ] ] ] ] ]
			           ifNone: [ false ].
		  found ~= false ]
]

{ #category : #activation }
MolPackagesCmdCommand class >> isAbstract [

	^ self = MolPackagesCmdCommand
]

{ #category : #execution }
MolPackagesCmdCommand >> selectedPackages [

	^ selectedItems collect: [ :p | p browserItem actualObject ]
]

{ #category : #execution }
MolPackagesCmdCommand >> selectedPackagesClasses [

	| classes |
	classes := Set new.
	self selectedPackages do: [ :p | classes addAll: p classes ].
	^ classes
]
