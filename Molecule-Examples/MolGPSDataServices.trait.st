Trait {
	#name : 'MolGPSDataServices',
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : 'Molecule-Examples-GPS Example',
	#package : 'Molecule-Examples',
	#tag : 'GPS Example'
}

{ #category : 'services' }
MolGPSDataServices >> getAccuracyRadiusInMeters [
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"
]
