Class {
	#name : 'MolExtensionsTest',
	#superclass : 'TestCase',
	#category : 'Molecule-Tests-Cases',
	#package : 'Molecule-Tests',
	#tag : 'Cases'
}

{ #category : 'tests' }
MolExtensionsTest >> setUp [

	MolComponentManager cleanUp
]

{ #category : 'tests' }
MolExtensionsTest >> tearDown [

	MolComponentManager cleanUp
]

{ #category : 'tests' }
MolExtensionsTest >> testHaveComponentType [

	self deny: MolAbstractComponentImpl haveComponentType.
	self assert: MolMyClientComponentImpl haveComponentType.
	
]

{ #category : 'tests' }
MolExtensionsTest >> testIsComponentClass [

	self deny: Object isComponentClass.
	self deny: 2 class isComponentClass.
	self deny: MolAbstractComponentImpl isComponentClass. "This class is not a component class, but subclasses yes"
	self assert: MolMyClientComponentImpl isComponentClass.
	self deny: MolMyClientComponentImpl class isComponentClass.
]

{ #category : 'tests' }
MolExtensionsTest >> testIsComponentType [

	self deny: MolComponentImpl isComponentType.
	self deny: MolComponentType isComponentType.
	self deny: TraitedClass isComponentType.
	
	self assert: MolMyClientComponent isComponentType.
]
