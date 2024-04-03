Class {
	#name : 'MolTestComponentTreeLevel1Impl',
	#superclass : 'MolAbstractComponentImpl',
	#traits : 'MolTestComponentTreeType',
	#classTraits : 'MolTestComponentTreeType classTrait',
	#category : 'Molecule-Tests-Resources - Components',
	#package : 'Molecule-Tests',
	#tag : 'Resources - Components'
}

{ #category : 'component life cycle' }
MolTestComponentTreeLevel1Impl >> componentActivate [

	MolComponentManager default homeServices activateComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element1) asSymbol.
	MolComponentManager default homeServices activateComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element2) asSymbol.
	MolComponentManager default homeServices activateComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element3) asSymbol.
]

{ #category : 'component life cycle' }
MolTestComponentTreeLevel1Impl >> componentInitialize [

	MolComponentManager default deploymentServices
		deployComponentImplementation: MolTestComponentTreeLevel2Impl.

	"start three others components to make a tree"
	MolComponentManager default homeServices
		instantiateComponent: MolTestComponentTreeLevel2Impl
		named: (self componentName , #level2element1) asSymbol.
	MolComponentManager default homeServices
		instantiateComponent: MolTestComponentTreeLevel2Impl
		named: (self componentName , #level2element2) asSymbol.
	MolComponentManager default homeServices
		instantiateComponent: MolTestComponentTreeLevel2Impl
		named: (self componentName , #level2element3) asSymbol
]

{ #category : 'component life cycle' }
MolTestComponentTreeLevel1Impl >> componentPassivate [

	MolComponentManager default homeServices passivateComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element1) asSymbol.
	MolComponentManager default homeServices passivateComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element2) asSymbol.
	MolComponentManager default homeServices passivateComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element3) asSymbol.
]

{ #category : 'component life cycle' }
MolTestComponentTreeLevel1Impl >> componentRemove [

	MolComponentManager default homeServices removeComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element1) asSymbol.
	MolComponentManager default homeServices removeComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element2) asSymbol.
	MolComponentManager default homeServices removeComponent: MolTestComponentTreeLevel2Impl named: (self componentName, #level2element3) asSymbol.
	
	
]
