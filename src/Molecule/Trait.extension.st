Extension { #name : 'Trait' }

{ #category : '*Molecule' }
Trait >> isComponentEvents [
	self = MolComponentEvents ifTrue: [ ^ false ].
	^ self traitComposition allTraits includes: MolComponentEvents
]

{ #category : '*Molecule' }
Trait >> isComponentParameters [
	self = MolComponentParameters ifTrue: [ ^ false ].
	^ self traitComposition allTraits includes: MolComponentParameters
]

{ #category : '*Molecule' }
Trait >> isComponentServices [
	self = MolComponentServices ifTrue: [ ^ false ].
	^ self traitComposition allTraits includes: MolComponentServices
]

{ #category : '*Molecule' }
Trait >> isComponentType [
	self = MolComponentType ifTrue: [ ^ false ].
	^ self traitComposition allTraits includes: MolComponentType
]
