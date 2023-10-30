Class {
	#name : #MolGNSSGPSInaccurate,
	#superclass : #Object,
	#traits : 'MolComponentImpl + MolGeoPosEquipmentType + MolGeoPosEquipmentServices',
	#classTraits : 'MolComponentImpl classTrait + MolGeoPosEquipmentType classTrait + MolGeoPosEquipmentServices classTrait',
	#instVars : [
		'sendCurrentPositionThread'
	],
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #'life cycle' }
MolGNSSGPSInaccurate >> componentActivate [
	"Start a thread to simulate sending of a fixed geo position each 2 seconds"

	sendCurrentPositionThread := [
	                             [ true ] whileTrue: [
		                         
		                             self getMolGeoPosEquipmentEventsNotifier
			                             currentPositionChanged: self getRandomizedGPSPosition.  (Delay forSeconds: 1) wait. ] ]
		                             forkAt:
		                             Processor userBackgroundPriority
]

{ #category : #'life cycle' }
MolGNSSGPSInaccurate >> componentPassivate [ 
	
	sendCurrentPositionThread ifNotNil:[ :e | e terminate ].
	sendCurrentPositionThread := nil.
]

{ #category : #services }
MolGNSSGPSInaccurate >> getAccuracyRadiusInMeters [
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"
	
	"convert precision in feet to meters"
	^(self precision * 0.3048)
]

{ #category : #'component accessing' }
MolGNSSGPSInaccurate >> getMolGeoPosEquipmentEventsNotifier [
	^self eventsNotifiers at: MolGeoPosEquipmentEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolGeoPosEquipmentEvents name: nil].
]

{ #category : #services }
MolGNSSGPSInaccurate >> getRandomizedGPSPosition [

	| random |
	random := Random new.
	^ random next @ random next
]

{ #category : #'GPS hardware existing API' }
MolGNSSGPSInaccurate >> precision [
	"Return GPS hardware precision (in feet)"

	^300
]
