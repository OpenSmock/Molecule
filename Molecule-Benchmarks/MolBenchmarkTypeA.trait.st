Trait {
	#name : #MolBenchmarkTypeA,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Benchmarks-Resources'
}

{ #category : #'accessing - events' }
MolBenchmarkTypeA classSide >> producedComponentEvents [
<componentContract>		
	^{ MolBenchmarkEventsA  }
]

{ #category : #'accessing - services' }
MolBenchmarkTypeA classSide >> providedComponentServices [
<componentContract>	
	^{ MolBenchmarkServicesA  } 
]
