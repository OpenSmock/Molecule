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
		
	self accuracy: 1000. "simulate beginning accuracy"
	
	"Start a thread to simulate sending of the geo position each seconds and accuracy precision"
	sendCurrentPositionThread := [ | random randomizedPosition nextAccuracy |
	 	[true] whileTrue:[

		self flag:'Factoriser le code pour ne voir que l important'.
		
			(Delay forSeconds: 1) wait.
			random := Random new.
			randomizedPosition := (random next)@(random next).
			
			self getMolGPSDataEventsNotifier currentPositionChanged: randomizedPosition.
			
			self accuracy > 1 ifTrue:[
				nextAccuracy :=  (self accuracy - (0.1 * self accuracy)). "10% better precision each seconds"
				nextAccuracy < 1 ifTrue:[nextAccuracy := 1].
				self accuracy: nextAccuracy.
			].
		].
	] forkAt: Processor userBackgroundPriority.
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
	^self eventsNotifiers at: MolGPSDataEvents ifAbsent: [nil]
]
