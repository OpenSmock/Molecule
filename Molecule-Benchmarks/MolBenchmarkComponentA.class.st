Class {
	#name : #MolBenchmarkComponentA,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolBenchmarkTypeA + MolBenchmarkServicesA',
	#classTraits : 'MolBenchmarkTypeA classTrait + MolBenchmarkServicesA classTrait',
	#instVars : [
		'myVariable'
	],
	#category : #'Molecule-Benchmarks-Benchs Components'
}

{ #category : #services }
MolBenchmarkComponentA >> componentInitialize [ 
	
	myVariable := 1.
]

{ #category : #'component accessing' }
MolBenchmarkComponentA >> getMolBenchmarkEventsANotifier [
	^self eventsNotifiers at: MolBenchmarkEventsA ifAbsent: [nil]
]

{ #category : #services }
MolBenchmarkComponentA >> getVariable [

	^myVariable
]

{ #category : #services }
MolBenchmarkComponentA >> sendAnEvent [

	self getMolBenchmarkEventsANotifier receiveAnEvent 
]

{ #category : #services }
MolBenchmarkComponentA >> sendAnEventWith [

	self getMolBenchmarkEventsANotifier receiveAnEventWith: myVariable
]
