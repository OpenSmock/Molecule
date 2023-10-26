Class {
	#name : #MolGNSSGalileo,
	#superclass : #Object,
	#traits : 'MolComponentImpl + MolGeoPosEquipmentType + MolGeoPosEquipmentServices',
	#classTraits : 'MolComponentImpl classTrait + MolGeoPosEquipmentType classTrait + MolGeoPosEquipmentServices classTrait',
	#instVars : [
		'sendCurrentPositionThread'
	],
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #'life cycle' }
MolGNSSGalileo >> componentActivate [
	"Start a thread to simulate sending of a fixed geo position each 2 seconds"

	sendCurrentPositionThread := [
	                             [ true ] whileTrue: [
		                             
		                             self getMolGeoPosEquipmentEventsNotifier
			                             currentPositionChanged: 1 @ 1. (Delay forSeconds: 1) wait. ] ]
		                             forkAt:
		                             Processor userBackgroundPriority
]

{ #category : #'life cycle' }
MolGNSSGalileo >> componentPassivate [ 
	
	sendCurrentPositionThread ifNotNil:[ :e | e terminate ].
	sendCurrentPositionThread := nil.
]

{ #category : #services }
MolGNSSGalileo >> getAccuracyRadiusInMeters [
	"Get and return the geolocation accuracy depending quantity of connected satellites"
	
	^self precision
]

{ #category : #'component accessing' }
MolGNSSGalileo >> getMolGeoPosEquipmentEventsNotifier [
	^self eventsNotifiers at: MolGeoPosEquipmentEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolGeoPosEquipmentEvents name: nil].
]

{ #category : #'GPS hardware existing API' }
MolGNSSGalileo >> precision [
	"Return geolocation precision (in meters)"

	^3
]
