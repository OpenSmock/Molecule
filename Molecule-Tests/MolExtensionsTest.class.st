Class {
	#name : #MolExtensionsTest,
	#superclass : #TestCase,
	#category : 'Molecule-Tests-Cases'
}

{ #category : #tests }
MolExtensionsTest >> setUp [

	MolComponentManager cleanUp
]

{ #category : #tests }
MolExtensionsTest >> tearDown [

	MolComponentManager cleanUp
]

{ #category : #tests }
MolExtensionsTest >> testHaveComponentType [

	self assert: MolAbstractComponentImpl  haveComponentType equals: false.
	self assert: MolMyClientComponentImpl haveComponentType.
	
]

{ #category : #tests }
MolExtensionsTest >> testIsComponentClass [

	self assert: Object isComponentClass equals: false.
	self assert: 2 class isComponentClass equals: false.
	self assert: MolAbstractComponentImpl isComponentClass.
	self assert: MolMyClientComponentImpl isComponentClass.
	self assert: MolMyClientComponentImpl class isComponentClass equals: false.
]

{ #category : #tests }
MolExtensionsTest >> testIsComponentType [

	self assert: MolComponentImpl isComponentType equals: false.
	self assert: MolComponentType isComponentType equals: false.
	self assert: MolMyClientComponent isComponentType.
]
