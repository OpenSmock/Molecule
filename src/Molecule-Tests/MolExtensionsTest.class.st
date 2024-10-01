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

	self deny: MolAbstractComponentImpl haveComponentType.
	self assert: MolMyClientComponentImpl haveComponentType.
	
]

{ #category : #tests }
MolExtensionsTest >> testIsComponentClass [

	| classes |
	self deny: Object isComponentClass.
	self deny: 2 class isComponentClass.
	self deny: MolAbstractComponentImpl isComponentClass. "This class is not a component class, but subclasses yes"
	self assert: MolMyClientComponentImpl isComponentClass.
	self deny: MolMyClientComponentImpl class isComponentClass.
	
	"test all system class"
	classes := Smalltalk globals allClasses.
	self assert: classes notEmpty.
	classes do:[ :c |
		self assert: ((c isComponentClass) isKindOf: Boolean).	
	].
]

{ #category : #tests }
MolExtensionsTest >> testIsComponentType [

	| traits |
	self deny: MolComponentImpl isComponentType.
	self deny: MolComponentType isComponentType.
	self deny: TraitedClass isComponentType.
	
	self assert: MolMyClientComponent isComponentType.
	
	"test all system class"
	traits := Smalltalk globals allTraits.
	self assert: traits notEmpty.
	traits do:[ :c |
		self assert: ((c isComponentType) isKindOf: Boolean).	
	].
]
