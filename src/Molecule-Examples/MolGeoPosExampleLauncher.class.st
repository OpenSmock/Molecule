"
Change the component implementation of GPSData on the fly :

1 - Start the demo 

MolGPSExampleLauncher start.

2 - Swap between available implementation :

MolGPSExampleLauncher swapGPSDataImplByGPSHardware.
MolGPSExampleLauncher swapGPSHardwareByGPSDataImpl.

3 - Stop the demo when you want

MolGPSExampleLauncher stop.
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
		 label: 'Molecule - GPS Example') ifTrue: [ Transcript open ].

	"Start GPSDataImpl component (a Component with MolGPSData Type)"
	MolGNSSGPS start.

	"Start GPSMapImpl component (a Component with MolGPSMap Type)"
	MolGeoPosMapImpl start
]

{ #category : #'start-stop' }
MolGeoPosExampleLauncher class >> stop [
	<script: 'self stop'>
	
	"General stop : Cleanup the Component Manager"
	MolComponentManager cleanUp
]

{ #category : #private }
MolGeoPosExampleLauncher class >> stopCurrentLaunchedComponent [
	"stops every possible component if it's launched"

	| manager component |
	manager := MolComponentManager default.

	component := manager locatorServices
		             searchComponentTypeImplementorFor: MolGeoPosEquipmentType.
	component class stop 
]

{ #category : #swap }
MolGeoPosExampleLauncher class >> swapGNSSGalileo [
	"Swap current component by MolGNSSGalileo"

	<script>
	self stopCurrentLaunchedComponent.
	MolGNSSGalileo start
]

{ #category : #swap }
MolGeoPosExampleLauncher class >> swapGPSDataImpl [
	"Swap current component by MolGPSDataImpl"

	<script>
	self stopCurrentLaunchedComponent.
	MolGNSSGPS start
]

{ #category : #swap }
MolGeoPosExampleLauncher class >> swapGPSHardware [
	"Swap current component by MolGPSHardware"

	<script>
	self stopCurrentLaunchedComponent.
	MolGNSSGPSInaccurate start
]

{ #category : #swap }
MolGeoPosExampleLauncher class >> swapGSM [
	"Swap current component by MolGSM"

	<script>
	self stopCurrentLaunchedComponent.
	MolGSM start
]

{ #category : #swap }
MolGeoPosExampleLauncher class >> swapWiFi [
	"Swap current component by MolWiFi"

	<script>
	self stopCurrentLaunchedComponent.
	MolWiFi start
]
