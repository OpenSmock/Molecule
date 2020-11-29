Extension { #name : #Trait }

{ #category : #'*Molecule' }
Trait >> isComponentType [

	self = MolComponentType ifTrue:[^false].
 	^ self traitComposition allTraits includes: MolComponentType
]
