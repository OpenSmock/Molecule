Extension { #name : #MolWorldMenuTest }

{ #category : #'*Molecule-IDE-Incubator-Tests' }
MolWorldMenuTest >> testWorldMenuIncubatorBuilding [
	| menuBuilder |
	menuBuilder := WorldState new menuBuilder.
	
	MolWorld menu21IncubatorOn: menuBuilder.
	MolWorld menu211InspectOn: menuBuilder.
	MolWorld menu212SearchOn: menuBuilder.
	MolWorld menu213CreateOn: menuBuilder.
]
