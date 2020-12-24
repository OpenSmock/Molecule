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
	#name : #MolGPSExampleLauncher,
	#superclass : #Object,
	#category : #'Molecule-Examples-GPS Example'
}

{ #category : #scripts }
MolGPSExampleLauncher class >> start [
	<script: 'self start'>
	
	(UITheme current
		proceedIn: Morph new 
		text: 'This example displays results in a Transcript, clic OK to open a Transcript.'
		title: 'Molecule - GPS Example') ifTrue:[Transcript open].
	
	"Start GPSDataImpl component (an implementation of MolGPSData Type)"
	MolUtils startComponent: MolGPSDataImpl.
	
	"Start GPSMapImpl component (an implementation of MolGPSMap Type)"
	MolUtils startComponent: MolGPSMapImpl.
]

{ #category : #scripts }
MolGPSExampleLauncher class >> stop [
	<script: 'self stop'>
	
	"Brutal stop : Cleanup the Component Manager"
	MolComponentManager cleanUp
]

{ #category : #scripts }
MolGPSExampleLauncher class >> swapGPSDataImplByGPSHardware [
	<script: 'self swapGPSDataImplByGPSHardware'>
	
	"Swap MolGPSDataImpl by MolGPSHardware"
	MolUtils stopComponent: MolGPSDataImpl.
	MolUtils startComponent: MolGPSHardware.

]

{ #category : #scripts }
MolGPSExampleLauncher class >> swapGPSHardwareByGPSDataImpl [
	<script: 'self swapGPSHardwareByGPSDataImpl'>
	
	"Swap MolGPSDataImpl by MolGPSHardware"
	MolUtils stopComponent: MolGPSHardware.
	MolUtils startComponent: MolGPSDataImpl.

]
