"
I am a utility class to transform a Molecule component into a Roassal graph.

Use #graphFromSingleComponent: aMolComponent to have a RSShape of the Molecule component.
Use #canvasFromMultipleComponents: aCollection to have a RSCanvas of multiple Molecule components.

"
Class {
	#name : #MolComponentToRoassal,
	#superclass : #Object,
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> canvasFromMultipleComponents: aCollectionOfComponents [

	| canvas dictionaryEvents lineBuilder |
	canvas := RSCanvas new.
	canvas addAll:
		(aCollectionOfComponents collect: [ :comp | comp asRSMoleculeShape ]).

	dictionaryEvents := Dictionary new.
	aCollectionOfComponents collect: [ :comp |
		comp servicesProviders keys , comp parametersProviders keys
		, comp eventsSubscribers keys do: [ :event |
			dictionaryEvents
				at: event
				ifPresent: [ :l | l add: comp ]
				ifAbsentPut: [ OrderedCollection with: comp ] ] ].

	lineBuilder := RSLineBuilder arrowedLine
		               canvas: canvas;
		               withBorderAttachPoint.

	aCollectionOfComponents do: [ :compSource |
		compSource eventsNotifiers keys do: [ :event |
			dictionaryEvents
				at: event
				ifPresent: [ :allComponentsForEvent |
					lineBuilder useAssociations:
						(allComponentsForEvent collect: [ :compTarget |
							 compSource -> compTarget ]) ]
				ifAbsent: [
					self flag: #TODO "No components has been found for this contract ..." ] ] ].

	RSForceBasedLayout new
		doNotUseProgressBar;
		length: 400;
		charge: -2000;
		on: canvas nodes.

	canvas @ RSCanvasController.
	canvas zoomToFit.
	^ canvas
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> connectorsFromEventCollection: aCollection andColor: aColor andCornerRadius: aCornerRadius [

	^ aCollection collect: [ :each |
		  | eventBox eventName |
		  eventName := RSLabel new
			               text: each printString;
			               color: Color black;
			               yourself.
		  eventBox := RSBox new
			              withBorder;
			              color: aColor;
			              extent: eventName extent + 10;
			              cornerRadius: aCornerRadius;
			              yourself.
		  RSComposite new
			  shapes: {
					  eventBox.
					  eventName };
			  adjustToChildren;
			  model: each;
			  yourself ]
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> connectorsInOn: aMolComponent [

	| connectors services events parameters |
	services := self
		            connectorsFromEventCollection:
		            aMolComponent servicesProviders keys
		            andColor: Color green muchLighter
		            andCornerRadius: (RSCornerRadius new right: 10).
	events := self
		          connectorsFromEventCollection:
		          aMolComponent eventsSubscribers keys
		          andColor: Color blue muchLighter
		          andCornerRadius: (RSCornerRadius new right: 10).
	parameters := self
		              connectorsFromEventCollection:
		              aMolComponent parametersProviders keys
		              andColor: Color red muchLighter
		              andCornerRadius: (RSCornerRadius new right: 10).
	connectors := RSComposite new
		              shapes: services , events , parameters;
		              yourself.
	connectors model: (connectors shapes collect: #model).

	RSVerticalLineLayout new
		alignLeft;
		on: connectors shapes.

	connectors adjustToChildren.
	^ connectors
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> connectorsOn: aMolComponent [

	| connectors connectorsIn connectorsOut model |
	connectorsIn := self connectorsInOn: aMolComponent.
	connectorsOut := self connectorsOutOn: aMolComponent.

	model := connectorsIn model asOrderedCollection
	         , connectorsOut model asOrderedCollection.

	(connectorsIn children isEmpty and: [
		 connectorsOut children isNotEmpty ]) ifTrue: [
		connectorsIn
			add: (RSBox new
					 extent: connectorsOut extent;
					 color: Color transparent;
					 model: aMolComponent;
					 yourself);
			adjustToChildren ].
	(connectorsOut children isEmpty and: [
		 connectorsIn children isNotEmpty ]) ifTrue: [
		connectorsOut
			add: (RSBox new
					 extent: connectorsIn extent;
					 color: Color transparent;
					 model: aMolComponent;
					 yourself);
			adjustToChildren ].

	connectors := RSComposite new
		              shapes: {
				              connectorsIn.
				              connectorsOut };
		              yourself.
	connectors model: model.

	RSHorizontalLineLayout new
		alignTop;
		on: connectors shapes.
	connectors adjustToChildren.
	^ connectors
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> connectorsOutOn: aMolComponent [

	| eventsOut connectors services events parameters |
	eventsOut := aMolComponent eventsNotifiers keys.
	services := self
		            connectorsFromEventCollection:
		            (eventsOut select: [ :each |
			             each usesTrait: MolComponentServices ])
		            andColor: Color green muchLighter
		            andCornerRadius: (RSCornerRadius new left: 10).
	events := self
		          connectorsFromEventCollection:
		          (eventsOut select: [ :each |
			           each usesTrait: MolComponentEvents ])
		          andColor: Color blue muchLighter
		          andCornerRadius: (RSCornerRadius new left: 10).
	parameters := self
		              connectorsFromEventCollection:
		              (eventsOut select: [ :each |
			               each usesTrait: MolComponentParameters ])
		              andColor: Color red muchLighter
		              andCornerRadius: (RSCornerRadius new left: 10).
	connectors := RSComposite new
		              shapes: services , events , parameters;
		              yourself.
	connectors model: (connectors shapes collect: #model).

	RSVerticalLineLayout new
		alignRight;
		on: connectors shapes.

	connectors adjustToChildren.
	^ connectors
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> graphFromSingleComponent: aMolComponent [

	| classNameLabel componentNameLabel connectors composite |
	classNameLabel := RSLabel new
		                  text: aMolComponent className;
		                  color: Color black lighter lighter;
		                  italic;
		                  fontSize: 14;
		                  yourself.
	componentNameLabel := RSLabel new
		                      text: aMolComponent componentName;
		                      color: Color black;
		                      fontSize: 18;
		                      yourself.

	connectors := self connectorsOn: aMolComponent.

	RSVerticalLineLayout new
		alignCenter;
		on: {
				componentNameLabel.
				classNameLabel.
				connectors }.

	composite := RSComposite new
		             draggable;
		             popupText: [ :comp | comp componentName ];
		             model: aMolComponent;
		             withBorder;
		             color: Color gray muchLighter;
		             shapes: {
				             componentNameLabel.
				             classNameLabel.
				             connectors };
		             yourself.
	composite adjustToChildren.
	composite extent: composite extent + (0 @ 20).
	composite @ (RSMenuActivable new menuDo: [ :aMenuMorph :anRSBox |
		 aMenuMorph
			 add: 'Inspect'
			 target: aMolComponent
			 selector: #inspect
			 argument: #(  ) ]).

	^ composite
]

{ #category : #'see class side' }
MolComponentToRoassal >> seeClassSide [
]
