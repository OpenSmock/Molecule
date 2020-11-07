Class {
	#name : #MolMyExistingGPSHardware,
	#superclass : #Object,
	#traits : 'MolComponentImpl + MolGPSData + MolGPSDataServices',
	#classTraits : 'MolComponentImpl classTrait + MolGPSData classTrait + MolGPSDataServices classTrait',
	#instVars : [
		'componentConnector',
		'componentName',
		'sendCurrentPositionThread'
	],
	#category : #'Molecule-Examples-GPS Example'
}

{ #category : #'component life cycle' }
MolMyExistingGPSHardware >> componentActivate [ 

	"Start a thread to simulate sending of a fixed geo position each 2 seconds"
	sendCurrentPositionThread := [
	 	[true] whileTrue:[
		
			(Delay forSeconds: 2) wait.
			self getMolGPSDataEventsNotifier currentPositionChanged: 1@1.
		].
	] forkAt: Processor userBackgroundPriority.
]

{ #category : #'private component accessing' }
MolMyExistingGPSHardware >> componentConnector [
	^componentConnector 
]

{ #category : #'private component accessing' }
MolMyExistingGPSHardware >> componentConnector: aConnector [
	componentConnector := aConnector.
]

{ #category : #'private component accessing' }
MolMyExistingGPSHardware >> componentName [
	^componentName
]

{ #category : #'private component accessing' }
MolMyExistingGPSHardware >> componentName: aName [
	componentName := aName
]

{ #category : #'component life cycle' }
MolMyExistingGPSHardware >> componentPassivate [ 
	
	sendCurrentPositionThread ifNotNil:[ :e | e terminate ].
	sendCurrentPositionThread := nil.
]

{ #category : #services }
MolMyExistingGPSHardware >> getAccuracyRadiusInMeters [
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"
	
	"convert feet to meters"
	^(self precision * 0.3048)
]

{ #category : #'component accessing' }
MolMyExistingGPSHardware >> getMolGPSDataEventsNotifier [
	^self eventsNotifiers at: MolGPSDataEvents ifAbsent: [nil]
]

{ #category : #'my existing GPS hardware API' }
MolMyExistingGPSHardware >> precision [

	"Return GPS hardware precision in feet"

	^3
]
