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

{ #category : #'instance creation' }
MolComponentToRoassal class >> associationsAllConsumedEventsAndTargetsFor: aMolComponent [

	^ aMolComponent componentConnector eventsSubscribers associations
		  collect: [ :asso |
			  MolRSContractModelTarget new
				  eventClass: asso key;
				  name: asso value;
				  component: aMolComponent;
				  color: self eventColor;
				  yourself ]
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> associationsAllProducedEventsAndTargetsFor: aMolComponent [

	^ aMolComponent class allProducedEvents collect: [ :event |
		MolRSContractModelSource new
				  eventClass: event;
				  name: aMolComponent componentName;
				  component: aMolComponent;
				  color: self eventColor;
				  yourself ].


]

{ #category : #'instance creation' }
MolComponentToRoassal class >> associationsAllProvidedParametersAndTargetsFor: aMolComponent [

	^ aMolComponent class allProvidedParameters collect: [ :event |
		MolRSContractModelSource new
				  eventClass: event;
				  name: aMolComponent componentName;
				  component: aMolComponent;
				  color: self parameterColor;
				  yourself ].
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> associationsAllProvidedServicesAndTargetsFor: aMolComponent [

	^ aMolComponent class allProvidedServices collect: [ :event |
		MolRSContractModelSource new
				  eventClass: event;
				  name: aMolComponent componentName;
				  component: aMolComponent;
				  color: self serviceColor;
				  yourself ].
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> associationsAllUsedParametersAndTargetsFor: aMolComponent [

	^ aMolComponent componentConnector parametersProviders associations collect: [ :asso |
			  MolRSContractModelTarget new
				  eventClass: asso key;
				  name: asso value;
				  component: aMolComponent;
				  color: self parameterColor;
				  yourself ]
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> associationsAllUsedServicesAndTargetsFor: aMolComponent [

	^ aMolComponent componentConnector servicesProviders associations collect: [ :asso |
			  MolRSContractModelTarget new
				  eventClass: asso key;
				  name: asso value;
				  component: aMolComponent;
				  color: self serviceColor;
				  yourself ]
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> canvasFromMultipleComponents: aCollectionOfComponents [

	| canvas componentShapes allEventShapes allContracts allContractSources allContractTargets lineBuilder |
	canvas := RSCanvas new.
	componentShapes := aCollectionOfComponents collect: [ :comp |
		                   comp asRSMoleculeShape ].
	canvas addAll: componentShapes.

	allEventShapes := componentShapes flatCollect: [ :a |
		                  | tempCollection |
		                  tempCollection := a children select: [ :b |
			                                    b model isCollection ].
		                  ((((tempCollection flatCollect: #children)
			                     flatCollect: #children) reject: [ :each |
			                    each model isComponent ]) flatCollect:
			                   #children) select: [ :c | c model isNotNil ] ].

	allContracts := allEventShapes collect: #model.
	allContractSources := allContracts select: [ :each |
		                      each isContractSource ].
	allContractTargets := allContracts reject: [ :each |
		                      each isContractSource ].

	lineBuilder := RSLineBuilder arrowedLine
		               canvas: canvas;
		               shapes: allEventShapes;
		               withBorderAttachPoint.

	allContractSources do: [ :source |
		| allAssociatedTargets |
		allAssociatedTargets := allContractTargets select: [ :target |
			                        target eventClass = source eventClass and: [
				                        target name = source name ] ].
		allAssociatedTargets do: [ :target |
			lineBuilder useAssociation: source -> target ] ].

	RSForceBasedLayout new
		doNotUseProgressBar;
		length: 3000;
		charge: -1000;
		on: canvas nodes.

	canvas @ RSCanvasController.
	canvas zoomToFit.
	^ canvas
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> canvasFromSingleComponent: aMolComponent [

	| canvas |
	canvas := RSCanvas new.
	canvas add: aMolComponent asRSMoleculeShape.
	canvas @ RSCanvasController.
	canvas zoomToFit.
	^ canvas
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> connectorsFromMolRSContracts: aCollectionOfMolRSContractModel [

	^ aCollectionOfMolRSContractModel collect: [ :rsContractModel |
		  | linkBox eventBox eventName |
		  eventName := RSLabel new
			               text: rsContractModel eventClass printString;
			               color: Color black;
			               yourself.

		  eventBox := RSBox new
			              withBorder;
			              color: rsContractModel color;
			              extent: eventName extent + 10;
			              cornerRadius: rsContractModel rsCornerRadius;
			              yourself.

		  linkBox := RSBox new
			             extent: 1 asPoint;
			             color: Color transparent;
			             model: rsContractModel;
			             yourself.
		  rsContractModel isContractSource
			  ifTrue: [ linkBox position: eventBox extent x / 2 @ 0 ]
			  ifFalse: [ linkBox position: eventBox extent x / -2 @ 0 ].

		  RSComposite new
			  shapes: {
					  linkBox.
					  eventBox.
					  eventName };
			  adjustToChildren;
			  model: rsContractModel eventClass;
			  yourself ]
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> connectorsInOn: aMolComponent [

	| connectors services events parameters |
	services := self
		            connectorsFromMolRSContracts:
		            (self associationsAllUsedServicesAndTargetsFor:
			             aMolComponent).
	events := self
		          connectorsFromMolRSContracts:
		          (self associationsAllConsumedEventsAndTargetsFor:
			           aMolComponent).
	parameters := self
		              connectorsFromMolRSContracts:
		              (self associationsAllUsedParametersAndTargetsFor:
			               aMolComponent).

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

	| connectors services events parameters |

	services := self connectorsFromMolRSContracts:
		            (self associationsAllProvidedServicesAndTargetsFor:
			             aMolComponent).
	events := self connectorsFromMolRSContracts:
		          (self associationsAllProducedEventsAndTargetsFor:
			           aMolComponent).
	parameters := self connectorsFromMolRSContracts:
		              (self associationsAllProvidedParametersAndTargetsFor:
			               aMolComponent).

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

{ #category : #color }
MolComponentToRoassal class >> eventColor [

	^ Color blue muchLighter
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

{ #category : #color }
MolComponentToRoassal class >> parameterColor [

	^ Color red muchLighter
]

{ #category : #color }
MolComponentToRoassal class >> serviceColor [

	^ Color green muchLighter
]

{ #category : #'see class side' }
MolComponentToRoassal >> seeClassSide [
]
