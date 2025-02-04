Extension { #name : #MolHomeServices }

{ #category : #'*Molecule-IDE' }
MolHomeServices >> inspectionDeployedComponentsGraph [

	<inspectorPresentationOrder: 0 title: 'Deployed Components Graph'>
	| canvas components |
	components := self deployedComponents flatCollect: #values.
	canvas := MolComponentToRoassal canvasFromMultipleComponents:
		          components.

	^ SpRoassalInspectorPresenter new
		  canvas: canvas;
		  yourself
]

{ #category : #'*Molecule-IDE' }
MolHomeServices >> openRoassalView [

	| components canvas |
	components := self deployedComponents flatCollect: #values.
	canvas := MolComponentToRoassal canvasFromMultipleComponents:
		          components.

	^ canvas openWithTitle: 'MolHomeService'
]
