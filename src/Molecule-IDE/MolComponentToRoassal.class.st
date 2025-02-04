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

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> activateLogoOf: aRSBox [

	(aRSBox propertyAt: #activateLogo) value
]

{ #category : #adding }
MolComponentToRoassal class >> addBreakpointOnceOnInstance: anInstance withSelector: aSelector [

	| bp ast |
	bp := Breakpoint new.
	ast := (anInstance class methodNamed: aSelector) ast.

	bp node: ast.
	bp scopeTo: anInstance.
	bp once: true.
	bp install
]

{ #category : #adding }
MolComponentToRoassal class >> addBreakpointOnceOnInstanceWithSelector: anArray [

	self addBreakpointOnceOnInstance: anArray first withSelector: anArray second
]

{ #category : #adding }
MolComponentToRoassal class >> addBreakpointOnceOnModelWithSelector: anArray [

	self
		addBreakpointOnceOnModel: anArray first
		withSelector: anArray second
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllConsumedEventsAndTargetsFor: aMolComponent [

	^ aMolComponent componentConnector ifNotNil: [ :connector | connector eventsSubscribers associations
		  collect: [ :asso |
			  MolRSContractModelTarget new
				  eventClass: asso key;
				  name: asso value;
				  component: aMolComponent;
				  yourself ] ].
		^ {  }
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllProducedEventsAndTargetsFor: aMolComponent [

	^ aMolComponent class allProducedEvents collect: [ :event |
		  MolRSContractModelSource new
			  eventClass: event;
			  name: aMolComponent componentName;
			  component: aMolComponent;
			  yourself ]
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllProvidedParametersAndTargetsFor: aMolComponent [

	^ aMolComponent class allProvidedParameters collect: [ :event |
		  MolRSContractModelSource new
			  eventClass: event;
			  name: aMolComponent componentName;
			  component: aMolComponent;
			  yourself ]
]

{ #category : #model }
MolComponentToRoassal class >> associationsAllProvidedServicesAndTargetsFor: aMolComponent [

	^ aMolComponent class allProvidedServices collect: [ :event |
		  MolRSContractModelSource new
			  eventClass: event;
			  name: aMolComponent componentName;
			  component: aMolComponent;
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
			self activateLogoOf: (lineBuilder fromShapes shapeFromModel: source).
			self activateLogoOf: (lineBuilder toShapes shapeFromModel: target).
			ghostLineBuilder useAssociation:
				source component -> target component ] ].

	"We change the color of not connected components"
	componentShapes
		reject: [ :shape | shape hasLines ]
		thenDo: [ :notConnectedComponent |
			notConnectedComponent color: Color yellow muchLighter ].

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

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> contractColorFor: aMolRSContractModel [

	(aMolRSContractModel eventClass includesTrait: MolComponentEvents)
		ifTrue: [ ^ self eventColor ].
	(aMolRSContractModel eventClass includesTrait: MolComponentServices)
		ifTrue: [ ^ self serviceColor ].
	^ self parameterColor
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

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> contractLogoFor: aMolRSContractModel [

	(aMolRSContractModel eventClass includesTrait: MolComponentEvents)
		ifTrue: [ ^ self eventLogo ].
	(aMolRSContractModel eventClass includesTrait: MolComponentServices)
		ifTrue: [ ^ self serviceLogo ].
	^ self parameterLogo
]

{ #category : #'instance creation' }
MolComponentToRoassal class >> contractsInFor: aMolComponent [

	| connectors services events parameters |
	services := (self associationsAllUsedServicesAndTargetsFor:
		             aMolComponent) sorted collect: [ :each |
		            self makeContractShapeFor: each ].
	events := (self associationsAllConsumedEventsAndTargetsFor:
		           aMolComponent) sorted collect: [ :each |
		          self makeContractShapeFor: each ].
	parameters := (self associationsAllUsedParametersAndTargetsFor:
		               aMolComponent) sorted collect: [ :each |
		              self makeContractShapeFor: each ].

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

	| connectors events services parameters |
	
	services := (self associationsAllProvidedServicesAndTargetsFor:
		             aMolComponent) sorted collect: [ :each |
		            self makeContractShapeFor: each ].
	events := (self associationsAllProducedEventsAndTargetsFor:
		           aMolComponent) sorted collect: [ :each |
		          self makeContractShapeFor: each ].
	parameters := (self associationsAllProvidedParametersAndTargetsFor:
		               aMolComponent) sorted collect: [ :each |
		              self makeContractShapeFor: each ].

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

{ #category : #resources }
MolComponentToRoassal class >> eventLogo [

	| rsLogoIn rsLogoOut |
	rsLogoIn := RSPieSlice new
		            withBorder;
		            externalRadius: 12;
		            innerRadius: 9;
		            alphaAngle: -90;
		            betaAngle: 90;
		            color: self eventColor;
		            yourself.
	rsLogoOut := RSCircle new
		             withBorder;
		             color: self eventColor;
		             size: 10 asPoint;
		             yourself.
	^ RSComposite new shapes: {
			  rsLogoIn.
			  rsLogoOut }
]

{ #category : #'as yet unclassified' }
MolComponentToRoassal class >> makeContractShapeFor: aMolRSContractModel [

	| linkBox eventBox eventName logo composite color |
	eventName := RSLabel new
		             text: aMolRSContractModel eventClass printString;
		             color: Color black;
		             yourself.

	color := self contractColorFor: aMolRSContractModel.
	eventBox := RSBox new
		            withBorder;
		            color: color;
		            extent: eventName extent + 10;
		            cornerRadius: aMolRSContractModel rsCornerRadius;
		            yourself.

	logo := self contractLogoFor: aMolRSContractModel.
	linkBox := RSBox new
		           extent: 1 asPoint;
		           color: Color transparent;
		           model: aMolRSContractModel;
		           propertyAt: #activateLogo put: [
			           logo nodes do: [ :each |
					           each
						           color: (color
								            alpha: 1;
								            adjustSaturation: 0.3 brightness: 0.09);
						           withBorder ] ];
		           yourself.

	aMolRSContractModel isContractSource
		ifTrue: [
			logo nodes first
				color: Color transparent;
				border: nil ]
		ifFalse: [
			logo nodes second
				color: Color transparent;
				border: nil ].

	aMolRSContractModel isContractSource
		ifTrue: [
			linkBox position: eventBox extent x / 2 @ 0.
			logo position: eventBox extent x / -2 - 16 @ 0 ]
		ifFalse: [
			linkBox position: eventBox extent x / -2 @ 0.
			logo position: eventBox extent x / 2 + 16 @ 0 ].

	composite := RSComposite new
		             shapes: {
				             linkBox.
				             eventBox.
				             eventName.
				             logo };
		             adjustToChildren;
		             model: aMolRSContractModel eventClass;
		             yourself.
	composite @ (RSMenuActivable new menuDo: [ :aMenuMorph :anRSBox |
		 aMenuMorph
			 add: 'Inspect Contract'
			 target: aMolRSContractModel
			 selector: #inspect
			 argument: #(  ).
		 aMolRSContractModel eventClass selectors do: [ :selector |
			 (aMolRSContractModel canBreakOn: selector) ifTrue: [
				 aMenuMorph
					 add: 'Break on #' , selector
					 target: aMolRSContractModel
					 selector: #breakOnceOnSelector:
					 argument: selector ] ] ]).
	^ composite
]

{ #category : #color }
MolComponentToRoassal class >> parameterColor [

	^ Color red muchLighter
]

{ #category : #resources }
MolComponentToRoassal class >> parameterLogo [

	| rsLogoIn rsLogoOut |
	rsLogoIn := RSPolygon new
	withBorder;
		            points: {
				            (0 @ 12).
				            (12 @ 12).
				            (12 @ -12).
				            (0 @ -12).
				            (0 @ -9).
				            (9 @ -9).
				            (9 @ 9).
				            (0 @ 9) };
		            color: self parameterColor;
		            yourself.
	rsLogoOut := RSBox new
	withBorder;
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

{ #category : #resources }
MolComponentToRoassal class >> serviceLogo [

	| rsLogoIn rsLogoOut |
	rsLogoIn := RSPolygon new
	withBorder;
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
	withBorder;
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
