Extension { #name : #MolComponentImpl }

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> asRSMoleculeShape [

	| implementationLabel componentNameLabel contracts composite componentTypeLabel componentNameText |
	componentTypeLabel := RSLabel new
		                      text: self class componentType asString;
		                      color: Color black;
		                      bold;
		                      fontSize: 18;
		                      yourself.

	implementationLabel := RSLabel new
		                       text: self className;
		                       color: Color black lighter lighter;
		                       italic;
		                       fontSize: 12;
		                       yourself.

	"don't display the default name to have better visual identification of named components"
	componentNameText := self componentName
	                     = MolUtils defaultComponentName
		                     ifTrue: [ '' ]
		                     ifFalse: [ '#' , self componentName ].

	componentNameLabel := RSLabel new
		                      text: componentNameText;
		                      color: Color black lighter;
		                      fontSize: 16;
		                      yourself.

	contracts := MolComponentToRoassal makeContractShapesFor: self.

	RSVerticalLineLayout new
		alignCenter;
		on: {
				componentTypeLabel.
				implementationLabel.
				componentNameLabel.
				contracts }.

	composite := RSComposite new
		             draggable;
		             popupText: [ :comp |
							             'Type: <1s><r>Impl: <2s><r>Name: <3s>'
								             expandMacrosWith: comp class componentType asString
								             with: comp className asString
								             with: comp componentName asString ];
		             model: self;
		             withBorder;
		             color: Color gray muchLighter;
		             shapes: {
				             componentTypeLabel.
				             implementationLabel.
				             componentNameLabel.
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
			 (aMenuMorph
				  add: 'Inspect component type implementors'
				  target: self
				  selector: #showComponentTypeImplementor
				  argument: #(  )) icon: (Smalltalk ui icons iconNamed: #dropDown).
			 aMenuMorph addSeparator.
			 (aMenuMorph
				  add: 'Break once when state switch to #initialize'
				  target: self class
				  selector: #breakOnceOnComponentInitialize) icon:
				 (Smalltalk ui icons iconNamed: #halt).
			 (aMenuMorph
				  add: 'Break once when state switch to #activate'
				  target: self class
				  selector: #breakOnceOnComponentActivate) icon:
				 (Smalltalk ui icons iconNamed: #halt).
			 (aMenuMorph
				  add: 'Break once when state switch to #passivate'
				  target: self class
				  selector: #breakOnceOnComponentPassivate) icon:
				 (Smalltalk ui icons iconNamed: #halt).
			 (aMenuMorph
				  add: 'Break once when state switch to #remove'
				  target: self class
				  selector: #breakOnceOnComponentRemove) icon:
				 (Smalltalk ui icons iconNamed: #halt).
			 (aMenuMorph
				  add: 'Break once when this component state switch to #activate'
				  target: self
				  selector: #breakObjectOrientedOnceOnComponentActivate) icon:
				 (Smalltalk ui icons iconNamed: #bug).
			 (aMenuMorph
				  add: 'Break once when state this component switch to #passivate'
				  target: self
				  selector: #breakObjectOrientedOnceOnComponentPassivate) icon:
				 (Smalltalk ui icons iconNamed: #bug).
			 (aMenuMorph
				  add: 'Break once when state this component switch to #remove'
				  target: self
				  selector: #breakObjectOrientedOnceOnComponentRemove) icon:
				 (Smalltalk ui icons iconNamed: #bug) ]).


	^ composite
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> breakObjectOrientedOnceOnComponentActivate [

	^ self breakObjectOrientedOnceOnComponentLifeCycle: #componentActivate
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> breakObjectOrientedOnceOnComponentLifeCycle: aSymbol [
	"We need to use the lookup to access the method if it is present in the super class or the trait."

	^ DebugPointManager
		  installNew: BreakDebugPoint
		  on: (self class lookupSelector: aSymbol) ast
		  forObject: self
		  withBehaviors: { OnceBehavior }
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> breakObjectOrientedOnceOnComponentPassivate [

	^ self breakObjectOrientedOnceOnComponentLifeCycle: #componentPassivate
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> breakObjectOrientedOnceOnComponentRemove [

	^ self breakObjectOrientedOnceOnComponentLifeCycle: #componentRemove
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
MolComponentImpl >> inspectionComponent: aBuilder [

	<inspectorPresentationOrder: 830 title: 'Component'>

	^ (aBuilder instantiate: SpRoassalInspectorPresenter)
		  canvas: (MolComponentToRoassal canvasFromSingleComponent: self);
		  yourself
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> showComponentTypeImplementor [

	^ MolImplementationsPresenter new
		  type: self class componentType;
		  open
]
