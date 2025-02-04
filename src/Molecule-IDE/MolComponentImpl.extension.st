Extension { #name : #MolComponentImpl }

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> allComponentClients [

	| clients allComponents |
	clients := Set new.
	allComponents := MolComponentManager default homeServices
		                 deployedComponents flatCollect: #values.
	^ allComponents select: [ :each |
		  each allComponentProviders includes: self ]
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> allComponentProviders [

	| providers locatorServices |
	providers := Set new.
	locatorServices := MolComponentManager default locatorServices.
	self servicesProviders keysAndValuesDo: [ :key :value |
		providers add:
			(locatorServices searchServicesProviderFor: key named: value) ].
	self parametersProviders keysAndValuesDo: [ :key :value |
		providers add:
			(locatorServices searchParametersProviderFor: key named: value) ].
	self eventsSubscribers keysAndValuesDo: [ :key :value |
		providers addAll:
			(locatorServices searchEventsSubscriberFor: key named: value)
				originators ].
	^ providers asArray
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> allComponentProvidersRecursive [

	| accumulator |
	accumulator := Set new.
	self allComponentProvidersRecursiveWithAccumulator: accumulator.
	^ (accumulator reject: [ :each | each = self ]) asArray
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> allComponentProvidersRecursiveWithAccumulator: anAccumulator [

	| providers |
	anAccumulator add: self.
	providers := self allComponentProviders.
	(providers difference: anAccumulator) do: [ :each |
		each allComponentProvidersRecursiveWithAccumulator: anAccumulator ]
]

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

	contracts := MolComponentToRoassal contractFromMolComponentImpl: self.

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
		 aMenuMorph
			 add: 'Inspect'
			 target: self
			 selector: #inspect
			 argument: #(  ) ]).

	^ composite
]

{ #category : #'*Molecule-IDE' }
MolComponentImpl >> inspectionComponent [

	<inspectorPresentationOrder: 830 title: 'Component'>

	^ SpRoassalInspectorPresenter new
		  canvas: (MolComponentToRoassal canvasFromSingleComponent: self);
		  yourself
]
