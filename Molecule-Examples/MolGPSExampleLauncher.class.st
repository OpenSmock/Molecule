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
	#name : 'MolGPSExampleLauncher',
	#superclass : 'Object',
	#category : 'Molecule-Examples-GPS Example',
	#package : 'Molecule-Examples',
	#tag : 'GPS Example'
}

{ #category : 'scripts' }
MolGPSExampleLauncher class >> start [

	<script: 'self start'>
	(UIManager default
		 confirm:
		 'This example displays results in a Transcript, do you want to open a transcript window ?'
		 label: 'Molecule - GPS Example') ifTrue: [ Transcript open ].

	"Start GPSDataImpl component (a Component with MolGPSData Type)"
	MolGPSDataImpl start.

	"Start GPSMapImpl component (a Component with MolGPSMap Type)"
	MolGPSMapImpl start
]

{ #category : 'scripts' }
MolGPSExampleLauncher class >> stop [
	<script: 'self stop'>
	
	"General stop : Cleanup the Component Manager"
	MolComponentManager cleanUp
]

{ #category : 'private' }
MolGPSExampleLauncher class >> stopCurrentLaunchedComponent [
	"stops every possible component if it's launched"

	| manager component |
	manager := MolComponentManager default.

	component := manager locatorServices
		             searchComponentTypeImplementorFor: MolGPSData.
	component class stop 
]

{ #category : 'scripts' }
MolGPSExampleLauncher class >> swapGNSSGalileo [
	"Swap current component by MolGNSSGalileo"

	<script>
	self stopCurrentLaunchedComponent.
	MolGNSSGalileo start
]

{ #category : 'scripts' }
MolGPSExampleLauncher class >> swapGPSDataImpl [
	"Swap current component by MolGPSDataImpl"

	<script>
	self stopCurrentLaunchedComponent.
	MolGPSDataImpl start
]

{ #category : 'scripts' }
MolGPSExampleLauncher class >> swapGPSHardware [
	"Swap current component by MolGPSHardware"

	<script>
	self stopCurrentLaunchedComponent.
	MolGPSHardware start
]

{ #category : 'scripts' }
MolGPSExampleLauncher class >> swapGSM [
	"Swap current component by MolGSM"

	<script>
	self stopCurrentLaunchedComponent.
	MolGSM start
]

{ #category : 'scripts' }
MolGPSExampleLauncher class >> swapWiFi [
	"Swap current component by MolWiFi"

	<script>
	self stopCurrentLaunchedComponent.
	MolWiFi start
]
