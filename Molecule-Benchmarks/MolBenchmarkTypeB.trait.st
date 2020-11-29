Trait {
	#name : #MolBenchmarkTypeB,
	#traits : 'MolComponentType',
	#classTraits : 'MolComponentType classTrait',
	#category : #'Molecule-Benchmarks-Benchs Components'
}

{ #category : #'accessing - events' }
MolBenchmarkTypeB classSide >> consumedComponentEvents [
<componentContract>	
	^{ MolBenchmarkEventsA } 
]

{ #category : #'accessing - services' }
MolBenchmarkTypeB classSide >> usedComponentServices [
<componentContract>	
	^{ MolBenchmarkServicesA   }
]
