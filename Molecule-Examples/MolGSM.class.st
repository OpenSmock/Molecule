Class {
	#name : 'MolGSM',
	#superclass : 'MolAbstractComponentImpl',
	#traits : 'MolGPSData + MolGPSDataServices',
	#classTraits : 'MolGPSData classTrait + MolGPSDataServices classTrait',
	#instVars : [
		'accuracy',
		'sendCurrentPositionThread'
	],
	#category : 'Molecule-Examples-GPS Example',
	#package : 'Molecule-Examples',
	#tag : 'GPS Example'
}

{ #category : 'accessing' }
MolGSM >> accuracy [

	^ accuracy
]

{ #category : 'accessing' }
MolGSM >> accuracy: anObject [

	accuracy := anObject
]

{ #category : 'accessing' }
MolGSM >> componentActivate [
	"Start a thread to simulate sending of the geo position and accuracy precision each second"

	sendCurrentPositionThread := [
	                             [ true ] whileTrue: [
		                             (Delay forMilliseconds: 50) wait.
		                             self getMolGPSDataEventsNotifier
			                             currentPositionChanged:
			                             self getRandomizedGSMPosition.
		                             self increaseAccuracy ] ] forkAt:
		                             Processor userBackgroundPriority
]

{ #category : 'accessing' }
MolGSM >> componentInitialize [
	"Set starting accuracy"

	self accuracy: 1000
]

{ #category : 'accessing' }
MolGSM >> componentPassivate [

	sendCurrentPositionThread ifNotNil: [ :e | e terminate ].
	sendCurrentPositionThread := nil
]

{ #category : 'accessing' }
MolGSM >> getAccuracyRadiusInMeters [
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"

	^ self accuracy
]

{ #category : 'component accessing' }
MolGSM >> getMolGPSDataEventsNotifier [
	^self eventsNotifiers at: MolGPSDataEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolGPSDataEvents name: nil].
]

{ #category : 'accessing' }
MolGSM >> getRandomizedGSMPosition [

	| random |
	random := Random new.
	^ random next * 3 @ random next * 3
]

{ #category : 'accessing' }
MolGSM >> increaseAccuracy [

	| nextAccuracy |
	self accuracy > 1 ifTrue: [
		nextAccuracy := self accuracy - (0.1 * self accuracy). "10% better precision at each times"
		nextAccuracy < 1 ifTrue: [ "stay to 1" nextAccuracy := 1 ].
		self accuracy: nextAccuracy ]
]
