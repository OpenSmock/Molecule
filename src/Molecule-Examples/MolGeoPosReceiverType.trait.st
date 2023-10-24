"
The TypeGPSMap requires to consume services of the GPSDataServicesinterface and to use events of the GPSDataEventsinterface.
"
Trait {
	#name : #MolGeoPosReceiverType,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #'accessing - events' }
MolGeoPosReceiverType classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolGeoPosEquipmentEvents  } 
]

{ #category : #'accessing - services' }
MolGeoPosReceiverType classSide >> usedComponentServices [
<componentContract>	
	^{ MolGeoPosEquipmentServices }
]
