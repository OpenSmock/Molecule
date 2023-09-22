"
Theses tests are writted to check error during component design, for example mistake from developper
"
Class {
	#name : #MolDirtyComponentTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #running }
MolDirtyComponentTest >> cleanGeneratedClassesAndTraits [
	"Clean generated stuff by each tests"
	<script: 'self new cleanGeneratedClassesAndTraits'>

	self class environment at: self generatedDirtyTypeImplementationSymbol ifPresent: [ :c | c removeFromSystem ].

]

{ #category : #accessing }
MolDirtyComponentTest >> generatedDirtyTypeImplementationSymbol [

	^ #MolDirtyImpl
]

{ #category : #accessing }
MolDirtyComponentTest >> generationTag [

	^ 'Molecule-Tests-Resources - Generated'
]

{ #category : #running }
MolDirtyComponentTest >> setUp [

	MolComponentManager cleanUp.
	self cleanGeneratedClassesAndTraits.
]

{ #category : #running }
MolDirtyComponentTest >> tearDown [

	(Delay forMilliseconds: 10) wait.
	self cleanGeneratedClassesAndTraits.
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolDirtyComponentTest >> testDirtyTypeWithInstanceVariableInsteadOfComponentTraits [

	"Create a component using a dirty Type"
	| component |
	MolComponentFactory createComponentForType: MolDirtyType named: self generatedDirtyTypeImplementationSymbol in: self generationTag.
	component := self class environment at: self generatedDirtyTypeImplementationSymbol.
	
	self deny: (component methodDictionary includesKey: #getnilSubscriber). 
	self deny: (component methodDictionary includesKey: #getnilNotifier). 
	self deny: (component methodDictionary includesKey: #getnilProvider).
	
	self assert: component allConsumedEvents isEmpty.
	self assert: component allProducedEvents isEmpty.
	self assert: component allProvidedServices isEmpty.
	self assert: component allUsedServices isEmpty.
	self assert: component allProvidedParameters isEmpty.
	self assert: component allUsedParameters isEmpty.
	
]
