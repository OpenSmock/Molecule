Class {
	#name : #MolGPSDataImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolGPSData + MolGPSDataServices',
	#classTraits : 'MolGPSData classTrait + MolGPSDataServices classTrait',
	#instVars : [
		'accuracy',
		'sendCurrentPositionThread'
	],
	#category : #'Molecule-Examples-GPS Example'
}

{ #category : #accessing }
MolGPSDataImpl >> accuracy [

	^ accuracy
]

{ #category : #accessing }
MolGPSDataImpl >> accuracy: anObject [

	accuracy := anObject
]

{ #category : #'component life cycle' }
MolGPSDataImpl >> componentActivate [ 
			
	"Start a thread to simulate sending of the geo position each seconds and accuracy precision"
	sendCurrentPositionThread := [
		
	 	[true] whileTrue:[
			(Delay forMilliseconds: 50) wait.
			self getMolGPSDataEventsNotifier currentPositionChanged: (self getRandomizedGPSPosition).
			self increaseAccuracy.
		].
	
	] forkAt: Processor userBackgroundPriority.
]

{ #category : #'component life cycle' }
MolGPSDataImpl >> componentInitialize [
		
	"Set starting accuracy"
	self accuracy: 1000. 
]

{ #category : #'component life cycle' }
MolGPSDataImpl >> componentPassivate [ 
	
	sendCurrentPositionThread ifNotNil:[ :e | e terminate ].
	sendCurrentPositionThread := nil.
]

{ #category : #services }
MolGPSDataImpl >> getAccuracyRadiusInMeters [
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"

	^self accuracy 
]

{ #category : #'component accessing' }
MolGPSDataImpl >> getMolGPSDataEventsNotifier [
	^self eventsNotifiers at: MolGPSDataEvents ifAbsent: [^MolNotFoundEventsNotifier new interface: MolGPSDataEvents name: nil].
]

{ #category : #private }
MolGPSDataImpl >> getRandomizedGPSPosition [

	| random |
	random := Random new.
	^ random next @ random next
]

{ #category : #private }
MolGPSDataImpl >> increaseAccuracy [

	| nextAccuracy |
	self accuracy > 1 ifTrue: [
		nextAccuracy := self accuracy - (0.1 * self accuracy). "10% better precision at each times"
		nextAccuracy < 1 ifTrue: [ "stay to 1" nextAccuracy := 1 ].
		self accuracy: nextAccuracy 
	]
]
