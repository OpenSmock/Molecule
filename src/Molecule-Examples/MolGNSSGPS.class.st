Class {
	#name : #MolGNSSGPS,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolGeoPosEquipmentType + MolGeoPosEquipmentServices',
	#classTraits : 'MolGeoPosEquipmentType classTrait + MolGeoPosEquipmentServices classTrait',
	#instVars : [
		'accuracy',
		'sendCurrentPositionThread'
	],
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #accessing }
MolGNSSGPS >> accuracy [

	^ accuracy
]

{ #category : #accessing }
MolGNSSGPS >> accuracy: anObject [

	accuracy := anObject
]

{ #category : #'life cycle' }
MolGNSSGPS >> componentActivate [
	"Start a thread to simulate sending of the geo position and accuracy precision each second"

	sendCurrentPositionThread := [ | percent |
		percent := 1.
	                             [ true ] whileTrue: [ 
		                             (Delay forMilliseconds: 100) wait.
		                             self getMolGeoPosEquipmentEventsNotifier
			                             currentPositionChanged: (self getGPSPosition: percent).
												percent := (percent + 1) min: 100.
		                             self increaseAccuracy ] ] forkAt:
		                             Processor userBackgroundPriority
]

{ #category : #'life cycle' }
MolGNSSGPS >> componentInitialize [

	"Set starting accuracy"

	self accuracy: 1000
]

{ #category : #'life cycle' }
MolGNSSGPS >> componentPassivate [ 
	
	sendCurrentPositionThread ifNotNil:[ :e | e terminate ].
	sendCurrentPositionThread := nil.
]

{ #category : #services }
MolGNSSGPS >> getAccuracyRadiusInMeters [
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"

	^self accuracy 
]

{ #category : #private }
MolGNSSGPS >> getGPSPosition: aPercent [

	| random |
	random := Random new.
	^ (random next @ random next) / aPercent
]

{ #category : #'component accessing' }
MolGNSSGPS >> getMolGeoPosEquipmentEventsNotifier [
	^self eventsNotifiers at: MolGeoPosEquipmentEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolGeoPosEquipmentEvents name: nil].
]

{ #category : #private }
MolGNSSGPS >> getRandomizedGPSPosition [

	| random |
	random := Random new.
	^ random next @ random next
]

{ #category : #private }
MolGNSSGPS >> increaseAccuracy [

	| nextAccuracy |
	self accuracy > 1 ifTrue: [
		nextAccuracy := self accuracy - (0.1 * self accuracy). "10% better precision at each times"
		nextAccuracy < 1 ifTrue: [ "stay to 1" nextAccuracy := 1 ].
		self accuracy: nextAccuracy 
	]
]
