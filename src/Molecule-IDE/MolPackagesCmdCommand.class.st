Class {
	#name : #MolPackagesCmdCommand,
	#superclass : #CmdCommand,
	#instVars : [
		'selectedPackages'
	],
	#category : #'Molecule-IDE-Commands'
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
MolPackagesCmdCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	selectedPackages := aToolContext selectedItems collect: [ :p |
		                   p browserItem actualObject ]
]

{ #category : #execution }
MolPackagesCmdCommand >> selectedPackages [

	^ selectedPackages
]
