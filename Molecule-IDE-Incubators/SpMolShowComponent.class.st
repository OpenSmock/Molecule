"
Window Spec for show a component
"
Class {
	#name : #SpMolShowComponent,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'popup',
		'component',
		'shape',
		'box',
		'usedComponentParameters',
		'usedComponentServices',
		'providedComponentServices',
		'providedComponentParameters',
		'producedComponentEvents',
		'consumedComponentEvents',
		'toProvidedServices',
		'fromUsedServices'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #specs }
SpMolShowComponent class >> defaultSpec [
	<spec: #default>
	^ SpBoxLayout newHorizontal
	add: #currentCanvas;
	yourself.
]

{ #category : #specs }
SpMolShowComponent class >> open [
	<script: 'self new openWithSpec'>
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> arrayName: array arrayOfComponents: interfaces [ 
	| composable  |
	toProvidedServices := OrderedCollection new.
	
	interfaces notNil ifTrue: [ 
		array shapes: ((1 to: interfaces size) collect: [ :n | 
			self model: (interfaces at:n). 
			composable := RSComposite new.
			composable 	
				model: (interfaces at:n);
				draggable;
				browseable;
				shapes: (self shapeModel: (interfaces at:n))
				yourself.	
			self labelComponent: (interfaces at:n).
			
			composable position: (-240)+(n*(60))@(n*(-70)+50).
			
			(composable shapes shapesFromModel: (self providedServices:(interfaces at:n))) nodes do: [:aShape | toProvidedServices add: aShape].
			"(composable shapes shapesFromModel: (self producedEvents:(interfaces at:n))) nodes do: [:aShape | toProducedEvents add: aShape]."
			composable @popup
		]).
	 ].
	
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> borderWith: aShape [
	^aShape border width: 0.5
]

{ #category : #accessing }
SpMolShowComponent >> box [
	^RSBox new
	extent: 50@50;
	color: Color white;
	cornerRadius: 5;
	borderColor: Color black.
]

{ #category : #accessing }
SpMolShowComponent >> box: aBox [
	box := aBox.
]

{ #category : #accessing }
SpMolShowComponent >> canvas: aCanvas [ 
	| camera |
	camera := aCanvas camera.
	aCanvas when: RSExtentChangedEvent do: [ :evt |
    | prevPoint prevScale |
    prevPoint := camera position.
    prevScale := camera scale.
    aCanvas nodes do: [ :node | 
        | fromScale toScale fromPoint toPoint |
        fromScale := prevScale.
        fromPoint := prevPoint.
        camera 
            zoomToFit: aCanvas extent * 0.9 
            rectangle: node encompassingRectangle.
        toScale := prevScale := camera scale.
        toPoint := prevPoint := camera position.
        node propertyAt: #fromPoint put: fromPoint.
        node propertyAt: #toPoint put: toPoint.
        node propertyAt: #fromScale put: fromScale.
        node propertyAt: #toScale put: toScale.
    ].
    aCanvas zoomToFit.
    prevPoint := camera position.
    prevScale := camera scale.
].
aCanvas nodes doWithIndex: [ :node :index |
    aCanvas newAnimation
        duration: 0.25 asSeconds ;
        "easing: RSEasing sinOut;"
        onStepDo: [ :t | 
            | fromPoint toPoint fromScale toScale |
            fromPoint := node propertyAt: #fromPoint.
            toPoint := node propertyAt: #toPoint.
            fromScale := node propertyAt: #fromScale.
            toScale := node propertyAt: #toScale.
            camera position: (fromPoint interpolateTo: toPoint at: t).
            camera scale: (fromScale interpolateTo: toScale at: t).
            ].
     ].
]

{ #category : #accessing }
SpMolShowComponent >> component [
	^component 
]

{ #category : #accessing }
SpMolShowComponent >> component: aComponent [
	component := aComponent
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> composable: aComposable shapes: aRSGroup [
	aComposable
		shapes: aRSGroup
		
]

{ #category : #initialization }
SpMolShowComponent >> configure: canvas [
	|  componentsInstances numbersOfComponentsInstances arrayOfUsedComponentServices componentShape lineServices |
	
	"test := component class.
	test2 := component allTraits."
	"components := OrderedCollection new.
	MolAbstractComponentImpl allSubInstancesDo:[ :comp | components add: comp ].
	MolComponentImpl users do: [:impl | impl allInstances do: [:comp | components add: comp ]]."
	
	componentsInstances := component allSubInstances.
	numbersOfComponentsInstances := componentsInstances size.
	
	self model: component. 
	componentShape := RSComposite new.
	componentShape
		position: 50@10;
		draggable;
		browseable;
		model: component;
		shapes: (self shapeModel: component) .
		
	arrayOfUsedComponentServices := RSComposite new.
	self arrayName: arrayOfUsedComponentServices arrayOfComponents: usedComponentServices.
	
	
	fromUsedServices := (componentShape shapes shapesFromModel: (self usedServices:component)) nodes at:1.
		
	toProvidedServices isNotNil 
	ifTrue: [ 
	lineServices := ((1 to: toProvidedServices size) collect: [:n | 
			RSBezier new
					withBorderAttachPoint;
					from: fromUsedServices;
					borderColor: Color blue;
					controlPointsController: RSVerticalCPAPController new;
					width: 0.5;
					to: (toProvidedServices at:n).
				]as:RSGroup).
		].
	
	"fromConsumedEvents := (componentShape shapes shapesFromModel: (self consumedEvents: component)) nodes at:1.
		
	toProducedEvents isNotNil 
	ifTrue: [ 
	lineEvents := ((1 to: to size) collect: [:n | 
			RSBezier new
					withBorderAttachPoint;
					from: fromConsumedEvents;
					borderColor: Color red;
					controlPointsController: RSVerticalCPAPController new;
					width: 0.5;
					to: (to at:n).
				]as:RSGroup).
		]."
	
	self labelComponent: component.
	self legend: canvas.
	
	"arrayOfComponent := RSComposite new
		shapes: { componentShape. arrayOfUsedComponentServices}."
	
	componentShape @ popup.
	canvas add: arrayOfUsedComponentServices ; add: componentShape; addAll:lineServices.
	canvas @ RSCanvasController.
	
	self canvas: canvas. 

	
]

{ #category : #initialization }
SpMolShowComponent >> connectPresenters [
	currentCanvas script: [ :canvas |
		self configure: canvas. ]
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> consumedComponentEventsConnected: consumedEvents [
	consumedComponentEvents :=  consumedEvents
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> consumedEvents: aComponent [
		(aComponent == MolAbstractComponentImpl) | (aComponent ==MolTestComponentImplA) | 
			(aComponent == MolTestComponentImplB) | (aComponent == MolTestComponentImplC)
		ifFalse: [ ^aComponent consumedComponentEvents   .]
		ifTrue: [ ^nil ]
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> initialize [
	super initialize.
	
	
	
	
	
]

{ #category : #initialization }
SpMolShowComponent >> initializePresenters [
	currentCanvas := self instantiate: SpRoassalPresenter.
	
	
	

]

{ #category : #initialization }
SpMolShowComponent >> initializeWindow: aWindowPresenter [

aWindowPresenter
	title: ('Show ', self component asString);
	initialExtent: 1000@700.
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> labelComponent: aComponent [

	| labelRequired labelComponentType labelUsedComponentServices labelConsumedComponentEvents labelUsedComponentParameters labelOffered labelProvidedComponentServices labelProvidedComponentParameters labelProducedComponentEvents |
	
	labelComponentType := RSLabel new  model: 'ComponentType : ', (self type: aComponent) asString.
	labelRequired := RSLabel new  model: 'REQUIRED'.
	labelUsedComponentServices := RSLabel new model: 'UsedServices : ', (self usedServices: aComponent) asString.
	labelConsumedComponentEvents := RSLabel new model: 'ConsumedEvents : ', (self consumedEvents: aComponent) asString.
	labelUsedComponentParameters := RSLabel new  model: 'UsedParameters : ', (self usedParameters: aComponent) asString.
	labelOffered := RSLabel new  model: 'OFFERED'.
	labelProvidedComponentServices := RSLabel new model: 'ProvidedServices : ', (self providedServices: aComponent) asString.
	labelProvidedComponentParameters := RSLabel new  model: 'ProvidedParameters : ', (self providedParameters: aComponent) asString.
	labelProducedComponentEvents := RSLabel new model: 'ProducedEvents : ' , (self producedEvents: aComponent) asString.
	
	popup := RSPopup new.
	popup shapeBuilder: [
	|  composite lb |
		composite := RSComposite new.
		lb := RSLegend new.
		lb container: composite.
		lb title: aComponent.
		{ labelComponentType. labelRequired.
		 labelUsedComponentServices.labelConsumedComponentEvents.labelUsedComponentParameters. 
		labelOffered. labelProvidedComponentServices. labelProducedComponentEvents.
		labelProvidedComponentParameters } do: [ :selector | lb text: selector model ].
		lb build.
		composite
			color: Color white;
			withBorder;
			padding: 5.
	].
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> labeled [
	|labeled |
	labeled := RSLabeled new.
	labeled location outer top.
	labeled fontSize: 2.
	labeled shapeBuilder labelShape color: Color black.
	^labeled
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> legend: aCanvas [

	| ellipseTypeLegend ellipseProvidedServicesLegend svgUsedServicesLegend polygonProducedEventsLegend
	svgConsumedEventsLegend svgUsedParametersLegend boxProvidedParametersLegend legend |
	
	ellipseTypeLegend := RSEllipse new color: Color black; model: 'ComponentType'.
	
	ellipseProvidedServicesLegend := RSEllipse new 
		color: Color white; 
		borderColor: Color black ;
		 model: 'ProvidedServices'.
	self borderWith: ellipseProvidedServicesLegend.
	
	svgUsedServicesLegend := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M 5 10 q 10 7 -1 11';
		model: 'UsedServices'.
		
	polygonProducedEventsLegend := RSPolygon new 
		points: (Array
		with: 0 @ 5
		with: 5 @ 0
		with: 0 @ -5
		with: -5 @ 0); 
		color: Color white; 
		borderColor: Color black; 
		model: 'ProducedEvents'.
	self borderWith: polygonProducedEventsLegend.
	
	svgConsumedEventsLegend := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M 10 10 l 5 -5 l -5 -5';
		model: 'ConsumedEvents'.
		
	svgUsedParametersLegend := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M 5 10 l 0 -7 l 9 0 l 0 7';
		model: 'UsedParameters'.
		
	boxProvidedParametersLegend := RSBox new
		color: Color white; borderColor: Color white;borderColor: Color black; model: 'ProvidedParameters'.
	self borderWith: boxProvidedParametersLegend.
	
	legend := RSLegend new.
	legend container: aCanvas.
	"legend defaultTitle fontSize: 4."
	legend title: 'Shapes Legend'.
	{ellipseTypeLegend. ellipseProvidedServicesLegend. polygonProducedEventsLegend.boxProvidedParametersLegend.
	svgUsedServicesLegend.svgConsumedEventsLegend. svgUsedParametersLegend} do: [ :selector |
		legend onDemand: 'Legend of components'.
		legend text: selector model withShape: selector.
		 ].
	legend legendDo: [ : border | border border:(RSBorder new color: 'C7EAE5'; width: 0.5); padding: 5. ].
	legend build.
	
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> line: aLine to: to [ 
	aLine
		color: Color black;
		from: box;
		to: to;
		withBorderAttachPoint;
		width: 0.5
		yourself.
]

{ #category : #accessing }
SpMolShowComponent >> model: aComponent [ 

aComponent componentType isNotNil ifTrue: [ 
		self usedServices: aComponent.
		self providedServices: aComponent.
		self consumedEvents: aComponent.
		self providedParameters: aComponent.
		self usedParameters: aComponent.
		self producedEvents: aComponent.
		].
	
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> producedComponentEventsConnected: producedEvents [
	producedComponentEvents :=  producedEvents
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> producedEvents: aComponent [
	(aComponent == MolAbstractComponentImpl) | (aComponent ==MolTestComponentImplA) | 
			(aComponent == MolTestComponentImplB) | (aComponent == MolTestComponentImplC)
		ifFalse: [ ^aComponent producedComponentEvents   .]
		ifTrue: [ ^nil ]
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> providedComponentParametersConnected: providedParameters [
	providedComponentParameters := providedParameters
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> providedComponentServicesConnected: providedServices [
	providedComponentServices := providedServices
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> providedParameters: aComponent [
	(aComponent == MolAbstractComponentImpl) | (aComponent ==MolTestComponentImplA) | 
			(aComponent == MolTestComponentImplB) | (aComponent == MolTestComponentImplC)
		ifFalse: [ ^aComponent providedComponentParameters  .]
		ifTrue: [ ^nil ]
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> providedServices: aComponent [
		(aComponent == MolAbstractComponentImpl) | (aComponent ==MolTestComponentImplA) | 
			(aComponent == MolTestComponentImplB) | (aComponent == MolTestComponentImplC)
		ifFalse: [ ^aComponent providedComponentServices .]
		ifTrue: [ ^nil ]
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> shape: aShape color: aColor model: aModel translateTo: aPoint [
	shape := aShape
		color: aColor;
		model: aModel;
		translateTo: aPoint;
		size:7
		yourself
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> shape: aShape color: aColor model: aModel translateTo: aPoint borderColor: aBorderColor [
	shape := aShape
		color: aColor;
		model: aModel;
		translateTo: aPoint;
		borderColor: aBorderColor;
		size:7
		yourself
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> shapeModel: aComponent [ 
	
	|componentImplementation lineType ellipseType lineConsumedEvents lineUsedServices boxProvidedParameters ellipseProvidedServices lineProvidedServices polygonProducedEvents lineProducedEvents lineProvidedParametersTest svgUsedParameters lineUsedParameters svgUsedServices svgConsumedEvents |
	
	componentImplementation := RSLabel new
			fontSize: 1.5;
			model: aComponent
			yourself.
	
	self box: self box.
	self borderWith: box.
	
	ellipseType := RSEllipse new.
	self 
		shape: ellipseType 
		color: Color black 
		model: (self type: aComponent)
		translateTo: 0@(-35).
		ellipseType @ (self labeled).
	
	lineType := RSLine new.
	self line: lineType to: ellipseType.
	
	ellipseProvidedServices := RSEllipse new.
	self 
		shape: ellipseProvidedServices 
		color: Color white 
		model: (self providedServices: aComponent)
		translateTo: 35@(-15)
		borderColor: Color black.
	self borderWith: ellipseProvidedServices.
	ellipseProvidedServices @ (self labeled).
	
	lineProvidedServices := RSLine new.
	self line: lineProvidedServices to: ellipseProvidedServices.
		
	polygonProducedEvents := RSPolygon new.
	polygonProducedEvents 
		points: (Array
		with: 0 @ 5
		with: 5 @ 0
		with: 0 @ -5
		with: -5 @ 0);
		translateTo: 35@15;
		color: Color white;
		borderColor: Color black
		yourself.
	polygonProducedEvents border width: 0.5.
	polygonProducedEvents model: (self producedEvents: aComponent).
	polygonProducedEvents @ (self labeled).
	
	lineProducedEvents := RSLine new.
	self line: lineProducedEvents to: polygonProducedEvents.
		
	boxProvidedParameters := RSBox new.
	self
		shape: boxProvidedParameters 
		color: Color white 
		model: (self providedParameters: aComponent)
		translateTo: 15@35
		borderColor: Color black.
	self borderWith: boxProvidedParameters.
	boxProvidedParameters @ (self labeled).
	
	"ellipseLifeCycleComponent := RSEllipse new color: Color black; translateTo: 10@20; size: 5."
	
	lineProvidedParametersTest := RSLine new.
	self line: lineProvidedParametersTest to: boxProvidedParameters.
		
	svgUsedParameters := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -19 39 l 0 -7 l 9 0 l 0 7'.
	svgUsedParameters model: (self usedParameters: aComponent).
	svgUsedParameters @(self labeled).
	
	lineUsedParameters := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -13 25 l -3 7';
		yourself.
		
	svgUsedServices := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -37 -22 q 10 7 -1 11';
		yourself.
	svgUsedServices model: (self usedServices: aComponent).
	svgUsedServices @(self labeled).
	
	lineUsedServices := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -32 -16 l 7 3';
		yourself.
		
	"usedServices := RSComposite new.
	usedServices shapes: { lineUsedServices. svgUsedServices }."

	svgConsumedEvents := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -37 18 l 5 -5 l -5 -5'.
	svgConsumedEvents model: (self consumedEvents: aComponent).
	svgConsumedEvents @ (self labeled).
	
	lineConsumedEvents := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -32 13 l 7 -3';
		yourself.
		
	^{box.lineType .ellipseType .componentImplementation.lineConsumedEvents.svgConsumedEvents.lineUsedParameters.svgUsedParameters.lineProvidedParametersTest.boxProvidedParameters.lineProducedEvents.polygonProducedEvents. lineProvidedServices.ellipseProvidedServices.lineUsedServices.svgUsedServices }
]

{ #category : #accessing }
SpMolShowComponent >> type: aComponent [
	"^component allTraits detect: [ :aClass | aClass usesTrait: MolComponentType ] ifNone: nil."
	^aComponent componentType
]

{ #category : #accessing }
SpMolShowComponent >> usedComponentParametersConnected: usedParameters [
	usedComponentParameters := usedParameters
]

{ #category : #accessing }
SpMolShowComponent >> usedComponentServicesConnected: usedServices [
	usedComponentServices := usedServices
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> usedParameters: aComponent [
	(aComponent == MolAbstractComponentImpl) | (aComponent ==MolTestComponentImplA) | 
			(aComponent == MolTestComponentImplB) | (aComponent == MolTestComponentImplC)
		ifFalse: [ ^aComponent usedComponentParameters.]
		ifTrue: [ ^nil ]
]

{ #category : #accessing }
SpMolShowComponent >> usedServices: aComponent [
	 (aComponent == MolAbstractComponentImpl) | (aComponent ==MolTestComponentImplA) | 
			(aComponent == MolTestComponentImplB) | (aComponent == MolTestComponentImplC)
		ifFalse: [ ^aComponent usedComponentServices.]
		ifTrue: [ ^nil ]
]
