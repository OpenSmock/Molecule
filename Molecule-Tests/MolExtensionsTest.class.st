Class {
	#name : #MolExtensionsTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
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
MolExtensionsTest >> testIsComponent [

	self assert: Object isComponent equals: false.
	self assert: 2 class isComponent equals: false.
	self assert: MolAbstractComponentImpl  isComponent.
	self assert: MolMyClientComponentImpl isComponent.
	
]

{ #category : #tests }
MolExtensionsTest >> testIsComponentType [

	self assert: MolComponentImpl isComponentType equals: false.
	self assert: MolComponentType isComponentType equals: false.
	self assert: MolMyClientComponent isComponentType.
]
