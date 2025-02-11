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

	| components canvas window |
	components := self deployedComponents flatCollect: #values.
	canvas := MolComponentToRoassal canvasFromMultipleComponents:
		          components.
	canvas add: (RSLabel new
			 text: 'Inspect';
			 isFixed: true;
			 position: 30 @ 10;
			 when: RSMouseClick do: [ :evt | self inspect ] for: self;
			 yourself).
	canvas add: (RSLabel new
			 text: 'Refresh';
			 isFixed: true;
			 position: 30 @ 30;
			 when: RSMouseClick do: [ :evt |
				 | extent position |
				 window ifNotNil: [
						 extent := window extent.
						 position := window position.
						 window close.
						 self openRoassalView
							 extent: extent;
							 position: position ] ]
			 for: self;
			 yourself).
	^ window := canvas openWithTitle: 'All deployed components'
]
