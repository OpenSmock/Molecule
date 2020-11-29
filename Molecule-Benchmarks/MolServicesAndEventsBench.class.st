Class {
	#name : #MolServicesAndEventsBench,
	#superclass : #MolBenchSuite,
	#instVars : [
		'componentA',
		'componentB'
	],
	#category : #'Molecule-Benchmarks-Benchs'
}

{ #category : #benchmarking }
MolServicesAndEventsBench >> benchCallServices [

	1 to: 100000 do:[ :i |
		componentB getMolBenchmarkServicesAProvider getVariable.
	].
]

{ #category : #benchmarking }
MolServicesAndEventsBench >> benchSendArgEvents [

	1 to: 100000 do:[ :i |
		componentA sendAnEventWith.
	].
]

{ #category : #benchmarking }
MolServicesAndEventsBench >> benchSendEvents [

	1 to: 100000 do:[ :i |
		componentA sendAnEvent.
	].
]

{ #category : #running }
MolServicesAndEventsBench >> setUp [ 
	
	componentA := MolUtils startComponent: MolBenchmarkComponentA.
	componentB := MolUtils startComponent: MolBenchmarkComponentB.
]

{ #category : #running }
MolServicesAndEventsBench >> tearDown [  
	
	MolUtils stopComponent: MolBenchmarkComponentB.
	MolUtils stopComponent: MolBenchmarkComponentA.
	
	componentA := nil.
	componentB := nil.
]
