"
A MolSourceCodeMetricsTest is a test class for testing the behavior of MolSourceCodeMetrics
"
Class {
	#name : #MolSourceCodeMetricsTest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #tests }
MolSourceCodeMetricsTest >> testClasses [

	| metrics |
	metrics := MolSourceCodeMetrics classes: (Array with: String).
	self assert: metrics classes size equals: 1.
	self assert: metrics classes first equals: String.
	self assert: metrics componentClasses isEmpty
]

{ #category : #tests }
MolSourceCodeMetricsTest >> testComponentClasses [

	| metrics |
	
	metrics := MolSourceCodeMetrics classes: (Array with: MolBasicComponentImpl).
	self assert: metrics classes size equals: 1.
	self assert: metrics classes first equals: MolBasicComponentImpl.
	self assert: metrics componentClasses size equals: 1.
]

{ #category : #tests }
MolSourceCodeMetricsTest >> testInitialize [

	| metrics |
	metrics := MolSourceCodeMetrics new.
	self assert: metrics classes isEmpty.
	self assert: metrics componentClasses isEmpty.
	self assert: metrics nbClasses equals: 0.
	self assert: metrics nbTraits equals: 0. 
	self assert: metrics nbClasseMethods equals: 0. 
	self assert: metrics nbInstanceMethods equals: 0. 
	self assert: metrics nbComponents equals: 0.
	self assert: metrics nbNativeComponents equals: 0.
	self assert: metrics nbAugmentedClassAsComponents equals: 0.
	self assert: metrics nbComponentTypes equals: 0.
	self assert: metrics nbServicesInterfaces equals: 0.
	self assert: metrics nbEventsInterfaces equals: 0.
	self assert: metrics nbParametersInterfaces equals: 0.
]

{ #category : #tests }
MolSourceCodeMetricsTest >> testMetrics [ 

	| metrics |
	metrics := MolSourceCodeMetrics classes: (Array with: MolBasicComponentImpl with: String with: MolBasicComponent).
	self assert: metrics nbClasses equals: 2.
	self assert: metrics nbTraits equals: 1. 
	self assert: metrics nbClasseMethods > 10.
	self assert: metrics nbInstanceMethods > 100.
	self assert: metrics nbComponents equals: 1.
	self assert: metrics nbNativeComponents equals: 1.
	self assert: metrics nbAugmentedClassAsComponents equals: 0.
	self assert: metrics nbComponentTypes equals: 1.
	self assert: metrics nbServicesInterfaces equals: 0.
	self assert: metrics nbEventsInterfaces equals: 0.
	self assert: metrics nbParametersInterfaces equals: 0.
]

{ #category : #tests }
MolSourceCodeMetricsTest >> testPrintMetrics [ 

	| metrics string |
	metrics := MolSourceCodeMetrics classes: (Array with: MolBasicComponentImpl).
	string := metrics printMetrics.
	self assert: string isString.
]
