Class {
	#name : #MolComponentStartAndStopBench,
	#superclass : #MolBenchSuite,
	#category : #'Molecule-Benchmarks-Benchs'
}

{ #category : #benchmarking }
MolComponentStartAndStopBench >> benchStartAndStopComponentA [
	<script: 'self profile: #benchStartAndStopComponentA'>

	MolComponentManager cleanUp.
	MolComponentManager default deploymentServices deployComponentImplementation: MolBenchmarkComponentA.

	1 to: 100 do:[ :i | | key |
		key :=  (#key, i printString) asSymbol.
		MolComponentManager default homeServices instanciateComponent: MolBenchmarkComponentA named:  key.
		MolComponentManager default homeServices activateComponent: MolBenchmarkComponentA named:  key.
	].

	1 to: 100 do:[ :i | | key |
		key :=  (#key, i printString) asSymbol.
		MolComponentManager default homeServices  passivateComponent: MolBenchmarkComponentA named: key.
		MolComponentManager default homeServices removeComponent: MolBenchmarkComponentA named: key.
	].

	MolComponentManager default deploymentServices undeployComponentImplementation: MolBenchmarkComponentA.
	MolComponentManager cleanUp.
]

{ #category : #benchmarking }
MolComponentStartAndStopBench >> benchStartAndStopComponentAandB [
	<script: 'self profile: #benchStartAndStopComponentAandB'>

	MolComponentManager cleanUp.
	MolComponentManager default deploymentServices deployComponentImplementation: MolBenchmarkComponentA.
	MolComponentManager default deploymentServices deployComponentImplementation: MolBenchmarkComponentB.

	1 to: 100 do:[ :i | | key comp |
		key :=  (#key, i printString) asSymbol.
		MolComponentManager default homeServices instanciateComponent: MolBenchmarkComponentA named:  key.	
		comp := MolComponentManager default homeServices instanciateComponent: MolBenchmarkComponentB named:  key.	
		comp forServices: MolBenchmarkServicesA useProvider: key.
		comp forEvents: MolBenchmarkEventsA useProducer: key.
		
		MolComponentManager default homeServices activateComponent: MolBenchmarkComponentA named:  key.
		MolComponentManager default homeServices activateComponent: MolBenchmarkComponentB named:  key.
	].

	1 to: 100 do:[ :i | | key |
		key :=  (#key, i printString) asSymbol.
		MolComponentManager default homeServices  passivateComponent: MolBenchmarkComponentA named:  key.
		MolComponentManager default homeServices  passivateComponent: MolBenchmarkComponentB named:  key.
		MolComponentManager default homeServices removeComponent: MolBenchmarkComponentA named:  key.
		MolComponentManager default homeServices removeComponent: MolBenchmarkComponentB named:  key.
	].

	MolComponentManager default deploymentServices undeployComponentImplementation: MolBenchmarkComponentA.
	MolComponentManager default deploymentServices undeployComponentImplementation: MolBenchmarkComponentB.
	MolComponentManager cleanUp.
]
