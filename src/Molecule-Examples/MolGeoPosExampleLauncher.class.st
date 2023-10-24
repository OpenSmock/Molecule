"
Change the started component of MolGeoPosEquipmentType Type on the fly.

1 - Start the demo: start a GPS equipment and a Map receiver (displaying result on Transcript) 

MolGeoPosExampleLauncher start.

2 - Choose between available geographical position equipments:

MolGeoPosExampleLauncher swapGPSInaccurate.
MolGeoPosExampleLauncher swapGSM.
MolGeoPosExampleLauncher swapGalileo.
MolGeoPosExampleLauncher swapWiFi.
MolGeoPosExampleLauncher swapGPS.

3 - To stop the demo:

MolGeoPosExampleLauncher stop.
"
Class {
	#name : #MolGeoPosExampleLauncher,
	#superclass : #Object,
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #'start-stop' }
MolGeoPosExampleLauncher class >> start [

	<script: 'self start'>
	(UIManager default
		 confirm:
		 'This example displays results in a Transcript, do you want to open a transcript window ?'
		 label: 'Molecule - Geographical Position Example') ifTrue: [ Transcript open ].

	"Start with GPS equipment by default"
	MolGNSSGPS start.

	"Start the geographical position receiver component: a component which is display the received position in a Transcript"
	MolGeoPosTranscriptReceiver start
]

{ #category : #'start-stop' }
MolGeoPosExampleLauncher class >> stop [
	<script: 'self stop'>
	
	"General stop : Cleanup the Component Manager"
	MolComponentManager cleanUp
]

{ #category : #private }
MolGeoPosExampleLauncher class >> stopCurrentGeoPosEquipment [
	"stops every possible component if it's launched"

	| manager component |
	manager := MolComponentManager default.

	component := manager locatorServices
		             searchComponentTypeImplementorFor: MolGeoPosEquipmentType.
	component class stop 
]

{ #category : #'select geo po equipment' }
MolGeoPosExampleLauncher class >> swapGPS [

	<script>
	self stopCurrentGeoPosEquipment.
	MolGNSSGPS start
]

{ #category : #'select geo po equipment' }
MolGeoPosExampleLauncher class >> swapGPSInaccurate [

	<script>
	self stopCurrentGeoPosEquipment.
	MolGNSSGPSInaccurate start
]

{ #category : #'select geo po equipment' }
MolGeoPosExampleLauncher class >> swapGSM [

	<script>
	self stopCurrentGeoPosEquipment.
	MolGSM start
]

{ #category : #'select geo po equipment' }
MolGeoPosExampleLauncher class >> swapGalileo [

	<script>
	self stopCurrentGeoPosEquipment.
	MolGNSSGalileo start
]

{ #category : #'select geo po equipment' }
MolGeoPosExampleLauncher class >> swapWiFi [

	<script>
	self stopCurrentGeoPosEquipment.
	MolWiFi start
]
