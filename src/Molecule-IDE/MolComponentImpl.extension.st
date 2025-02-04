Extension { #name : #MolComponentImpl }

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> asRSMoleculeShape [

	| classNameLabel componentNameLabel contracts composite |
	classNameLabel := RSLabel new
		                  text: self className;
		                  color: Color black lighter lighter;
		                  italic;
		                  fontSize: 14;
		                  yourself.
	componentNameLabel := RSLabel new
		                      text: self componentName;
		                      color: Color black;
		                      fontSize: 18;
		                      yourself.

	contracts := MolComponentToRoassal makeContractShapesFor: self.

	RSVerticalLineLayout new
		alignCenter;
		on: {
				componentNameLabel.
				classNameLabel.
				contracts }.

	composite := RSComposite new
		             draggable;
		             popupText: [ :comp | comp componentName ];
		             model: self;
		             withBorder;
		             color: Color gray muchLighter;
		             shapes: {
				             componentNameLabel.
				             classNameLabel.
				             contracts };
		             yourself.
	composite adjustToChildren.
	composite extent: composite extent + (0 @ 20).
	composite @ (RSMenuActivable new menuDo: [ :aMenuMorph :anRSBox |
		 (aMenuMorph
			  add: 'Inspect component'
			  target: self
			  selector: #inspect
			  argument: #(  )) icon:
			 (Smalltalk ui icons iconNamed: #smallInspectIt).
		 (aMenuMorph
			  add: 'Browse component'
			  target: self
			  selector: #browse
			  argument: #(  )) icon: (Smalltalk ui icons iconNamed: #nautilus) ]).

	^ composite
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> inspectionComponent [

	<inspectorPresentationOrder: 830 title: 'Component'>

	^ SpRoassalInspectorPresenter new
		  canvas: (MolComponentToRoassal canvasFromSingleComponent: self);
		  yourself
]
