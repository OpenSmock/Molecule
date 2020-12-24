"
This test component start and manage a component tree (start and stop others components)
"
Class {
	#name : #MolTestComponentTreeLevel0Impl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolTestComponentTreeType',
	#classTraits : 'MolTestComponentTreeType classTrait',
	#category : #'Molecule-Tests-Resources'
}

{ #category : #'component life cycle' }
MolTestComponentTreeLevel0Impl >> componentActivate [

	MolComponentManager default homeServices activateComponent: MolTestComponentTreeLevel1Impl named: #level1element1.
	MolComponentManager default homeServices activateComponent: MolTestComponentTreeLevel1Impl named: #level1element2.
	MolComponentManager default homeServices activateComponent: MolTestComponentTreeLevel1Impl named: #level1element3.
]

{ #category : #'component life cycle' }
MolTestComponentTreeLevel0Impl >> componentInitialize [ 

	MolComponentManager default deploymentServices deployComponentImplementation: MolTestComponentTreeLevel1Impl.

	"start three others components to make a tree"
	MolComponentManager default homeServices instanciateComponent: MolTestComponentTreeLevel1Impl named: #level1element1.
	MolComponentManager default homeServices instanciateComponent: MolTestComponentTreeLevel1Impl named: #level1element2.
	MolComponentManager default homeServices instanciateComponent: MolTestComponentTreeLevel1Impl named: #level1element3.
]

{ #category : #'component life cycle' }
MolTestComponentTreeLevel0Impl >> componentPassivate [

	MolComponentManager default homeServices passivateComponent: MolTestComponentTreeLevel1Impl named: #level1element1.
	MolComponentManager default homeServices passivateComponent: MolTestComponentTreeLevel1Impl named: #level1element2.
	MolComponentManager default homeServices passivateComponent: MolTestComponentTreeLevel1Impl named: #level1element3.
]

{ #category : #'component life cycle' }
MolTestComponentTreeLevel0Impl >> componentRemove [

	MolComponentManager default homeServices removeComponent: MolTestComponentTreeLevel1Impl named: #level1element1.
	MolComponentManager default homeServices removeComponent: MolTestComponentTreeLevel1Impl named: #level1element2.
	MolComponentManager default homeServices removeComponent: MolTestComponentTreeLevel1Impl named: #level1element3.
]
