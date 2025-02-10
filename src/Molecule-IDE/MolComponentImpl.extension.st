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
			  argument: #(  )) icon: (Smalltalk ui icons iconNamed: #nautilus).
		 aMenuMorph addSeparator.
		(aMenuMorph
			  add: 'Halt Once when new component #initialize'
			  target: self
			  selector: #haltOnComponentInitialize) icon:
			 (Smalltalk ui icons iconNamed: #halt).
			(aMenuMorph
			  add: 'Halt Once when new component #activate'
			  target: self
			  selector: #haltOnComponentActivate) icon:
			 (Smalltalk ui icons iconNamed: #halt).
		 (aMenuMorph
			  add: 'Halt when #passivate'
			  target: self
			  selector: #haltOnComponentPassivate) icon:
			 (Smalltalk ui icons iconNamed: #halt).
		 (aMenuMorph
			  add: 'Halt when #remove'
			  target: self
			  selector: #haltOnComponentRemove) icon:
			 (Smalltalk ui icons iconNamed: #halt) ]).

	^ composite
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl classSide >> breakOnceOnComponentActivate [

	^ self breakOnceOnComponentLifeCycle: #componentActivate
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl classSide >> breakOnceOnComponentInitialize [

	^ self breakOnceOnComponentLifeCycle: #componentInitialize
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl classSide >> breakOnceOnComponentLifeCycle: aSymbol [

	| debugPoint condition |
	"We need to use the lookup to access the method if it is present in the super class or the trait."
	debugPoint := DebugPointManager
		              installNew: BreakDebugPoint
		              on: (self lookupSelector: aSymbol) ast
		              withBehaviors: { OnceBehavior }.
	
	"We need to add a condition that check the class since the lookup will trigger for any class that have the targeted method, including all the trait users that may implement MolComponentImpl trait."
	condition := ConditionBehavior new
		             condition:
			             ('self class = <1s>' expandMacrosWith: self name);
		             yourself.
	debugPoint addBehavior: condition.
	^ debugPoint
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl classSide >> breakOnceOnComponentPassivate [

	^ self breakOnceOnComponentLifeCycle: #componentPassivate
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl classSide >> breakOnceOnComponentRemove [

	^ self breakOnceOnComponentLifeCycle: #componentRemove
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> haltOnComponentActivate [

	^ self class haltOnComponentActivate
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> haltOnComponentInitialize [

	^ self class haltOnComponentInitialize
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> haltOnComponentPassivate [

	^ self haltOnceOnCallTo: #componentPassivate
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> haltOnComponentRemove [

	^ self haltOnceOnCallTo: #componentRemove
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> inspectionComponent [

	<inspectorPresentationOrder: 830 title: 'Component'>

	^ SpRoassalInspectorPresenter new
		  canvas: (MolComponentToRoassal canvasFromSingleComponent: self);
		  yourself
]
