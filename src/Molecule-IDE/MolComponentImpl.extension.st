Extension { #name : #MolComponentImpl }

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> asRSMoleculeShape [

	^ MolComponentToRoassal graphFromSingleComponent: self
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> inspectionComponent [

	<inspectorPresentationOrder: 830 title: 'Component'>

	^ SpRoassalInspectorPresenter new
		  canvas: (MolComponentToRoassal canvasFromSingleComponent: self);
		  yourself
]
