"
The GPSData component type uses the Molecule base Type MolComponentType. 
This base Type provides the skeleton methods providedComponentServices and producedComponentEvents.
"
Trait {
	#name : #MolGeoPosEquipmentType,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #'accessing - events' }
MolGeoPosEquipmentType classSide >> producedComponentEvents [
<componentContract>		
	^{ MolGeoPosEquipmentEvents } 
]

{ #category : #'accessing - services' }
MolGeoPosEquipmentType classSide >> providedComponentServices [
<componentContract>	
	^{ MolGeoPosEquipmentServices  } 
]
