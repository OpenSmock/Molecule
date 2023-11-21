# Tests
To create quick tests for your Components, you can create a package named [yourPackageName]-Examples or [yourPackageName]-Tests, then create an Object subclass named [yourPackageName]Examples, 
```smalltalk
Object subclass: #MolGPS-Examples
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Molecule-Tutorial'
```
then display the **Class side** of this class.
This then allows the creation of methods for different test cases.

One practical thing is putting a `<script>` tag at the start of your methods. This will create a small icon next to your method in order to launch it without the use of a Playground.
```smalltalk
MolGPS-Examples>>start

	<script: 'self start'>
	(UIManager default
		 confirm:
		 'This example displays results in a Transcript, do you want to open a transcript window ?'
		 label: 'Molecule - GPS Example') ifTrue: [ Transcript open ].

	"Start GPSDataImpl component (a Component with MolGPSData Type)"
	MolGPSDataImpl start.

	"Start GPSMapImpl component (a Component with MolGPSMap Type)"
	MolGPSMapImpl start
```

This can also be applied for stopping Components.
```smalltalk
MolGPS-Examples>>stop
	"General stop : Cleanup the Component Manager"

	<script: 'self stop'>
	MolComponentManager cleanUp
```

## Order of Components
You also need to verify the order of Components starting since a Component that listens to another needs to be started before the latter one. Otherwise, events will be sent wthout any component listening to it, rendering it meaningless.
In this example, that means that `MolGPSMapImpl` needs to be started **after** `MolGPSDataImpl`.

## Switching Components on the fly
This test space can be useful for switching Components on the fly, stopping a component to start another having a different Type (make sure that they have a different name or that the current launched Component is stopped before the other of the same Type is launched).
See the Molecule-Examples package for more examples on this.

## Calling another script
To call another script, you simply have to call it like a regular function with `self [script]` since the `self` here represents the current class (for methods located in the class side).
The stop script could be for example launched in the `start` script after a certain period of time passed through `self stop`.
