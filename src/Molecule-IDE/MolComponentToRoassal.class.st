"
I am a utility class to transform a Molecule component into a Roassal graph.

Use `#canvasFromSingleComponent: aMolComponent` to have a `RSCanvas` of a single `MolComponentImpl`.
Use `#canvasFromMultipleComponents: aCollection` to have a `RSCanvas` of multiple `MolComponentImpl`.

"
Class {
	#name : #MolComponentToRoassal,
	#superclass : #Object,
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #model }
MolComponentToRoassal class >> associationsAllConsumedEventsAndTargetsFor: aMolComponent [

	^ aMolComponent componentConnector eventsSubscribers associations
		  collect: [ :asso |
			  MolRSContractModelTarget new
				  eventClass: asso key;
				  name: asso value;
				  component: aMolComponent;
				  color: self eventColor;
				  rsLogo: self eventLogo;
				  yourself ]
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllProducedEventsAndTargetsFor: aMolComponent [

	^ aMolComponent class allProducedEvents collect: [ :event |
		  MolRSContractModelSource new
			  eventClass: event;
			  name: aMolComponent componentName;
			  component: aMolComponent;
			  color: self eventColor;
			  rsLogo: self eventLogo;
			  yourself ]
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllProvidedParametersAndTargetsFor: aMolComponent [

	^ aMolComponent class allProvidedParameters collect: [ :event |
		  MolRSContractModelSource new
			  eventClass: event;
			  name: aMolComponent componentName;
			  component: aMolComponent;
			  color: self parameterColor;
			  rsLogo: self parameterLogo;
			  yourself ]
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllProvidedServicesAndTargetsFor: aMolComponent [

	^ aMolComponent class allProvidedServices collect: [ :event |
		  MolRSContractModelSource new
			  eventClass: event;
			  name: aMolComponent componentName;
			  component: aMolComponent;
			  color: self serviceColor;
			rsLogo: self serviceLogo;
			  yourself ]
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllUsedParametersAndTargetsFor: aMolComponent [

	^ aMolComponent componentConnector parametersProviders associations
		  collect: [ :asso |
			  MolRSContractModelTarget new
				  eventClass: asso key;
				  name: asso value;
				  component: aMolComponent;
				  color: self parameterColor;
				rsLogo: self parameterLogo;
				  yourself ]
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllUsedServicesAndTargetsFor: aMolComponent [

	^ aMolComponent componentConnector servicesProviders associations
		  collect: [ :asso |
			  MolRSContractModelTarget new
				  eventClass: asso key;
				  name: asso value;
				  component: aMolComponent;
				  color: self serviceColor;
				rsLogo: self serviceLogo;
				  yourself ]
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> canvasFromMultipleComponents: aCollectionOfComponents [

	| canvas componentShapes allEventShapes allContracts allContractSources allContractTargets lineBuilder ghostLineBuilder |
	canvas := RSCanvas new.
	componentShapes := aCollectionOfComponents collect: [ :comp |
		                   comp asRSMoleculeShape ].
	canvas addAll: componentShapes.

	"We need tor recover all the contract shape in the roassal elements tree.
	The code is a bit spaghetti ..."
	allEventShapes := componentShapes flatCollect: [ :a |
		                  | tempCollection |
		                  tempCollection := a children select: [ :b |
			                                    b model isCollection ].
		                  ((((tempCollection flatCollect: #children)
			                     flatCollect: #children) reject: [ :each |
			                    each model isComponent ]) flatCollect:
			                   #children) select: [ :c | c model isNotNil ] ].

	"We create the link between the element.
	We need to types of links:
	- the displayed arrow that will be created by the `lineBuilder`.
	- an invisible link that will be used for the layout that will be created by the `ghostLineBuilder`."
	lineBuilder := RSLineBuilder arrowedLine
		               canvas: canvas;
		               shapes: allEventShapes;
		               withBorderAttachPoint.
	ghostLineBuilder := RSLineBuilder line
		                    canvas: canvas;
		                    shapes: componentShapes;
		                    color: Color transparent;
		                    withBorderAttachPoint.

	allContracts := allEventShapes collect: #model.
	allContractSources := allContracts select: [ :each |
		                      each isContractSource ].
	allContractTargets := allContracts reject: [ :each |
		                      each isContractSource ].
	allContractSources do: [ :source |
		| allAssociatedTargets |
		allAssociatedTargets := allContractTargets select: [ :target |
			                        target eventClass = source eventClass and: [
				                        target name = source name ] ].
		allAssociatedTargets do: [ :target |
			lineBuilder useAssociation: source -> target.
			"We use the rsShape included in the model to update the logo display on the graph."
			source rsLogoActivate.
			target rsLogoActivate.
			ghostLineBuilder useAssociation:
				source component -> target component ] ].
	
	"We change the color of not connected components"
	componentShapes reject: [ :shape | shape hasLines ] thenDo: [ :notConnectedComponent | notConnectedComponent color: Color yellow muchLighter ].

	"We create a layout for the components:
	- if they are not connected: they will be aligned on the top-left corner.
	- if they are connected: they will be displayed as a RSHorizontalTreeLayout, all trees will be ina a RSGridLayout."
	RSConditionalLayout new
		ifNotConnectedThen: (RSVerticalLineLayout new
				 gapSize: 20;
				 yourself);
		else: (RSClusteringLayout new
				 clustersLayout: (RSGridLayout new
						  gapSize: 20;
						  yourself);
				 forEachLayout: (RSHorizontalTreeLayout new
						  horizontalGap: 500;
						  verticalGap: 20;
						  yourself));
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
MolComponentToRoassal class >> contractFromMolComponentImpl: aMolComponent [

	| contractsAll contractsIn contractsOut model |
	contractsIn := self contractsInFor: aMolComponent.
	contractsOut := self contractsOutFor: aMolComponent.

	model := contractsIn model asOrderedCollection
	         , contractsOut model asOrderedCollection.

	(contractsIn children isEmpty and: [
		 contractsOut children isNotEmpty ]) ifTrue: [
		contractsIn
			add: (RSBox new
					 extent: contractsOut extent;
					 color: Color transparent;
					 model: aMolComponent;
					 yourself);
			adjustToChildren ].
	(contractsOut children isEmpty and: [
		 contractsIn children isNotEmpty ]) ifTrue: [
		contractsOut
			add: (RSBox new
					 extent: contractsIn extent;
					 color: Color transparent;
					 model: aMolComponent;
					 yourself);
			adjustToChildren ].

	contractsAll := RSComposite new
		                shapes: {
				                contractsIn.
				                contractsOut };
		                yourself.
	contractsAll model: model.

	RSHorizontalLineLayout new
		alignTop;
		on: contractsAll shapes.
	contractsAll adjustToChildren.
	^ contractsAll
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> contractsFromMolRSContracts: aCollectionOfMolRSContractModel [

	^ aCollectionOfMolRSContractModel collect: [ :rsContractModel |
		  | linkBox eventBox eventName logo |
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
		  logo := rsContractModel rsLogo.
		  rsContractModel isContractSource
			  ifTrue: [
				  linkBox position: eventBox extent x / 2 @ 0.
				  logo position: eventBox extent x / -2 - 16 @ 0 ]
			  ifFalse: [
				  linkBox position: eventBox extent x / -2 @ 0.
				  logo position: eventBox extent x / 2 + 16 @ 0 ].

		  RSComposite new
			  shapes: {
					  linkBox.
					  eventBox.
					  eventName.
					  logo };
			  adjustToChildren;
			  model: rsContractModel eventClass;
			  yourself ]
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> contractsInFor: aMolComponent [

	| connectors services events parameters |
	services := self contractsFromMolRSContracts:
		            (self associationsAllUsedServicesAndTargetsFor:
			             aMolComponent) sorted.
	events := self contractsFromMolRSContracts:
		          (self associationsAllConsumedEventsAndTargetsFor:
			           aMolComponent) sorted.
	parameters := self contractsFromMolRSContracts:
		              (self associationsAllUsedParametersAndTargetsFor:
			               aMolComponent) sorted.

	connectors := RSComposite new
		              shapes: events , services , parameters;
		              yourself.
	connectors model: (connectors shapes collect: #model).

	RSVerticalLineLayout new
		alignLeft;
		on: connectors shapes.

	connectors adjustToChildren.
	^ connectors
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> contractsOutFor: aMolComponent [

	| connectors services events parameters |
	services := self contractsFromMolRSContracts:
		            (self associationsAllProvidedServicesAndTargetsFor:
			             aMolComponent) sorted.
	events := self contractsFromMolRSContracts:
		          (self associationsAllProducedEventsAndTargetsFor:
			           aMolComponent) sorted.
	parameters := self contractsFromMolRSContracts:
		              (self associationsAllProvidedParametersAndTargetsFor:
			               aMolComponent) sorted.

	connectors := RSComposite new
		              shapes: events , services , parameters;
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

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> eventLogo [
	
	| rsLogoIn rsLogoOut |
	rsLogoIn := RSPieSlice new
		            externalRadius: 12;
		            innerRadius: 9;
		            alphaAngle: 90;
		            betaAngle: -90;
		            color: self eventColor;
		            yourself.
	rsLogoOut := RSCircle new
		             color: self eventColor;
		             size: 10 asPoint;
		             yourself.
	^ RSComposite new shapes: {
			  rsLogoIn.
			  rsLogoOut }
]

{ #category : #color }
MolComponentToRoassal class >> parameterColor [

	^ Color red muchLighter
]

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> parameterLogo [

	| rsLogoIn rsLogoOut |
	rsLogoIn := RSPolygon new
		            points: { 0@12 . 12@12 . 12 @ -12 . 0 @ -12 . 0 @ -9 . 9 @ -9 . 9@9 . 0 @ 9 };
		            color: self parameterColor;
		            yourself.
	rsLogoOut := RSBox new
		             color: self parameterColor;
		             size: 10 asPoint;
		             yourself.
	^ RSComposite new shapes: {
			  rsLogoIn.
			  rsLogoOut }
]

{ #category : #color }
MolComponentToRoassal class >> serviceColor [

	^ Color green muchLighter
]

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> serviceLogo [

	| rsLogoIn rsLogoOut |
	rsLogoIn := RSPolygon new
		            points: {
				            (0 @ 12).
				            (12 @ 0).
				            (0 @ -12).
				            (0 @ -9).
				            (9 @ 0).
				            (0 @ 9) };
		            color: self serviceColor;
		            yourself.
	rsLogoOut := RSPolygon new
		             points: {
				             (0 @ 5).
				             (5 @ 0).
				             (0 @ -5).
				             (-5 @ -0) };
		             color: self serviceColor;
		             yourself.
	^ RSComposite new shapes: {
			  rsLogoIn.
			  rsLogoOut }
]

{ #category : #'see class side' }
MolComponentToRoassal >> seeClassSide [
]
