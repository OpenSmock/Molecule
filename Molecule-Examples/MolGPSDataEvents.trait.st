Trait {
	#name : #MolGPSDataEvents,
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : 'Molecule-Examples-GPS Example'
}

{ #category : #events }
MolGPSDataEvents >> currentPositionChanged: aGeoPosition [
	"Notify the current geographic position of the GPSreceiver when changed"
]
