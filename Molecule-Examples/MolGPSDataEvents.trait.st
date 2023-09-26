Trait {
	#name : 'MolGPSDataEvents',
	#traits : 'MolComponentEvents',
	#classTraits : 'MolComponentEvents classTrait',
	#category : 'Molecule-Examples-GPS Example',
	#package : 'Molecule-Examples',
	#tag : 'GPS Example'
}

{ #category : 'events' }
MolGPSDataEvents >> currentPositionChanged: aGeoPosition [
	"Notify the current geographic position of the GPSreceiver when changed"
]
