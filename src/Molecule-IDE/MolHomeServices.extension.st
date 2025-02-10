Extension { #name : #MolHomeServices }

{ #category : #'*Molecule-IDE' }
MolHomeServices >> inspectionDeployedComponentsGraph [

	<inspectorPresentationOrder: 1000 title: 'Deployed Components Graph'>
	| canvas components |
	self deployedComponents ifNil: [ ^ SpNullPresenter new ].
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

	^ canvas openWithTitle: 'All deployed components'
]
