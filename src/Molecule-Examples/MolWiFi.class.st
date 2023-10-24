Class {
	#name : #MolWiFi,
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
MolWiFi >> accuracy [

	^ accuracy
]

{ #category : #accessing }
MolWiFi >> accuracy: anObject [

	accuracy := anObject
]

{ #category : #accessing }
MolWiFi >> componentActivate [
	"Start a thread to simulate sending of the geo position and accuracy precision each second"

	sendCurrentPositionThread := [
	                             [ true ] whileTrue: [
		                             (Delay forMilliseconds: 50) wait.
		                             self getMolGeoPosEquipmentEventsNotifier
			                             currentPositionChanged:
			                             self getRandomizedWiFiPosition.
		                             self increaseAccuracy ] ] forkAt:
		                             Processor userBackgroundPriority
]

{ #category : #accessing }
MolWiFi >> componentInitialize [
	"Set starting accuracy"

	self accuracy: 1000
]

{ #category : #accessing }
MolWiFi >> componentPassivate [

	sendCurrentPositionThread ifNotNil: [ :e | e terminate ].
	sendCurrentPositionThread := nil
]

{ #category : #accessing }
MolWiFi >> getAccuracyRadiusInMeters [
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"

	^ self accuracy
]

{ #category : #'component accessing' }
MolWiFi >> getMolGeoPosEquipmentEventsNotifier [
	^self eventsNotifiers at: MolGeoPosEquipmentEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolGeoPosEquipmentEvents name: nil].
]

{ #category : #accessing }
MolWiFi >> getRandomizedWiFiPosition [

	| random |
	random := Random new.
	^ random next * 4 @ random next * 4
]

{ #category : #accessing }
MolWiFi >> increaseAccuracy [

	| nextAccuracy |
	self accuracy > 1 ifTrue: [
		nextAccuracy := self accuracy - (0.1 * self accuracy). "10% better precision at each times"
		nextAccuracy < 1 ifTrue: [ "stay to 1" nextAccuracy := 1 ].
		self accuracy: nextAccuracy ]
]
