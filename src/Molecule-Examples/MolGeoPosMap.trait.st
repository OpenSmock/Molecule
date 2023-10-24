"
The TypeGPSMap requires to consume services of the GPSDataServicesinterface and to use events of the GPSDataEventsinterface.
"
Trait {
	#name : #MolGeoPosMap,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #'accessing - events' }
MolGeoPosMap classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolGeoPosEquipmentEvents  } 
]

{ #category : #'accessing - services' }
MolGeoPosMap classSide >> usedComponentServices [
<componentContract>	
	^{ MolGeoPosEquipmentServices }
]
