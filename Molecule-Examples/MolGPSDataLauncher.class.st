"
Change the component implementation of GPSData on the fly :

1 - Start the demo 

MolGPSDataLauncher start

2 - Swap current implementation by MyExistingGPSHardware :

""Stop GPSDataImpl component""
MolComponentManager default homeServices passivateComponent: MolGPSDataImpl.
MolComponentManager default homeServices removeComponent: MolGPSDataImpl.

""Start MolMyExistingGPSHardware component""
MolComponentManager default deploymentServices deployComponentImplementation: MolMyExistingGPSHardware.
MolComponentManager default homeServices instanciateComponent: MolMyExistingGPSHardware.
MolComponentManager default homeServices activateComponent: MolMyExistingGPSHardware.

""Swap another time""
MolComponentManager default homeServices passivateComponent: MolMyExistingGPSHardware.
MolComponentManager default homeServices removeComponent: MolMyExistingGPSHardware.
MolComponentManager default homeServices instanciateComponent: MolGPSDataImpl.
MolComponentManager default homeServices activateComponent: MolGPSDataImpl.

3 - Stop the demo when you want

MolGPSDataLauncher stop
"
Class {
	#name : #MolGPSDataLauncher,
	#superclass : #Object,
	#category : #'Molecule-Examples-GPS Example'
}

{ #category : #scripts }
MolGPSDataLauncher class >> start [
	<script: 'self start'>
	
	"Start GPSDataImpl component"
	MolComponentManager default deploymentServices deployComponentImplementation: MolGPSDataImpl.
	MolComponentManager default homeServices instanciateComponent: MolGPSDataImpl.
	MolComponentManager default homeServices activateComponent: MolGPSDataImpl.
	
	"Start GPSMapImpl component"
	MolComponentManager default deploymentServices deployComponentImplementation: MolGPSMapImpl.
	MolComponentManager default homeServices instanciateComponent: MolGPSMapImpl.
	MolComponentManager default homeServices activateComponent: MolGPSMapImpl.
]

{ #category : #scripts }
MolGPSDataLauncher class >> stop [
	<script: 'self stop'>
	
	"Cleanup the Component Manager"
	MolComponentManager cleanUp
]
