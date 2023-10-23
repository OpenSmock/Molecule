"
The TypeGPSMap requires to consume services of the GPSDataServicesinterface and to use events of the GPSDataEventsinterface.
"
Trait {
	#name : #MolGPSMap,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : 'Molecule-Examples-GPS Example'
}

{ #category : #'accessing - events' }
MolGPSMap classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolGPSDataEvents  } 
]

{ #category : #'accessing - services' }
MolGPSMap classSide >> usedComponentServices [
<componentContract>	
	^{ MolGPSDataServices }
]
