"
A MolComponentTypeTest is a test class for testing the behavior of MolComponentType
"
Class {
	#name : #MolComponentTypeTest,
	#superclass : #TestCase,
	#category : 'Molecule-Tests-Cases - Component Contract'
}

{ #category : #tests }
MolComponentTypeTest >> testAllConsumedEvents [

	self assert: MolComponentType allConsumedEvents isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testAllProducedEvents [

	self assert: MolComponentType allProducedEvents isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testAllProvidedParameters [

	self assert: MolComponentType allProvidedParameters isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testAllProvidedServices [

	self assert: MolComponentType allProvidedServices isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testAllUsedParameters [

	self assert: MolComponentType allUsedParameters isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testAllUsedServices [

	self assert: MolComponentType allUsedServices isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testConsumedComponentEvents [

	self assert: MolComponentType consumedComponentEvents isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testIsConsumeEvents [

	self assert: (MolComponentType isConsumeEvents: nil) equals: false.
	self assert: (MolComponentType isConsumeEvents: MolComponentEvents) equals: false.
]

{ #category : #tests }
MolComponentTypeTest >> testIsProduceEvents [

	self assert: (MolComponentType isProduceEvents: nil) equals: false.
	self assert: (MolComponentType isProduceEvents: MolComponentEvents) equals: false.
]

{ #category : #tests }
MolComponentTypeTest >> testIsProvideParameters [

	self assert: (MolComponentType isProvideParameters: nil) equals: false.
	self assert: (MolComponentType isProvideParameters: MolComponentParameters) equals: false.
]

{ #category : #tests }
MolComponentTypeTest >> testIsProvideServices [

	self assert: (MolComponentType isProvideServices: nil) equals: false.
	self assert: (MolComponentType isProvideServices: MolComponentServices) equals: false.
]

{ #category : #tests }
MolComponentTypeTest >> testIsUseParameters [

	self assert: (MolComponentType isUseParameters: nil) equals: false.
	self assert: (MolComponentType isUseParameters: MolComponentParameters) equals: false.
]

{ #category : #tests }
MolComponentTypeTest >> testIsUseServices [

	self assert: (MolComponentType isUseServices: nil) equals: false.
	self assert: (MolComponentType isUseServices: MolComponentServices) equals: false.
]

{ #category : #tests }
MolComponentTypeTest >> testProducedComponentEvents [

	self assert: MolComponentType producedComponentEvents isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testProvidedComponentParameters [

	self assert: MolComponentType providedComponentParameters isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testProvidedComponentServices [

	self assert: MolComponentType providedComponentServices isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testProvidedComponentServicesmeters [

	self assert: MolComponentType providedComponentServices isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testUsedComponentParameters [

	self assert: MolComponentType usedComponentParameters isEmpty.
]

{ #category : #tests }
MolComponentTypeTest >> testUsedComponentServices [

	self assert: MolComponentType usedComponentServices isEmpty.
]
