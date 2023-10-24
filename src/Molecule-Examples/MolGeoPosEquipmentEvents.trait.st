Trait {
	#name : #MolGeoPosEquipmentEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #events }
MolGeoPosEquipmentEvents >> currentPositionChanged: aGeoPosition [
	"Notify the current geographic position of the receiver when changed"
]
