"
We give an overview of Molecule through two examples :
- Clock System
- Geographical Position

#Clock System
Before running the example open the Transcript, the example results is showed on the Transcript window.

MolMyClockSystem startAlarmExample.

This system uses 4 components: a server time send global hour to a clock. The clock send local hour to alarms and to final user (which could be an UI). The final user can change the parameters of the system as alarm time or set manual time for the clock. The alarm is subscribed to clock time, and sounds when it is time.
This system provides a global example of the use of components.

#Geographical Position
The example results are showing on the Transcript window.

MolGeoPosExampleLauncher start.
More details about examples in the comment of MolGeoPosExampleLauncher.

We program a component application that connects to a Global Positioning System (GPS) and displays the GPS received position on a view map (just fictitious). 
The GPS and Map are implemented as Molecule components.

There are others available equipment as Galileo, GSM or WiFi, which provide geographical position.

We reuse an existing non-component class in our Molecule application (MolGNSSGPSInnacurate).
To do so, we augment this class with component behavior.
"
Class {
	#name : #ManifestMoleculeExamples,
	#superclass : #PackageManifest,
	#category : #'Molecule-Examples-Manifest'
}
