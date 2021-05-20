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
		'molPopup',
		'molContract',
		'ellipseProvidedServices',
		'polygonProducedEvents',
		'boxProvidedParameters',
		'svgUsedParameters',
		'svgUsedServices',
		'svgConsumedEvents',
		'toProducedEvents',
		'toUsedParameters',
		'toProvidedParameters',
		'toConsumedEvents',
		'toUsedServices',
		'componentShape',
		'ellipseType',
		'lineProvidedParameters',
		'componentImplementation',
		'lineType',
		'lineProvidedServices',
		'lineProducedEvents',
		'lineUsedParameters',
		'lineUsedServices',
		'lineConsumedEvents',
		'svgRelationConsumedEvents',
		'svgRelationProvidedParameters',
		'svgRelationUsedServices',
		'svgRelationUsedParameters',
		'svgRelationProducedEvents',
		'svgRelationProvidedServices',
		'legend',
		'ellipseTypeLegend',
		'ellipseProvidedServicesLegend',
		'svgUsedServicesLegend',
		'polygonProducedEventsLegend',
		'svgConsumedEventsLegend',
		'svgUsedParametersLegend',
		'boxProvidedParametersLegend'
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
SpMolShowComponent >> arrayOfComponents: interfaces shape: aShape collection: collection [ 
	| composable array |
	array := RSComposite new.
	interfaces notNil ifTrue: [ 
		array shapes: ((1 to: interfaces size) collect: [ :n |  
			composable := RSComposite new.
			composable 	
				model: (interfaces at:n);
				draggable;
				shapes: (self shapeModel: (interfaces at:n))
				yourself.	
			self popup: (interfaces at:n).
			self event: composable.
			
			collection == toProvidedServices ifTrue: [ 
			composable position: (-250)+(n*(70))@(n*(-50)).
			composable shapes do: [:node | (node == ellipseProvidedServices) ifTrue: [ toProvidedServices add: node ]]].
		
			collection == toProducedEvents ifTrue: [ 
			composable position: (-250)+(n*(70))@(n*(-50) + 140).
			composable shapes do: [:node | (node == polygonProducedEvents) ifTrue: [ toProducedEvents add: node ]]].
		
			collection == toProvidedParameters ifTrue: [ 
			composable position: (-160)+(n*(70))@(n*(-50) + 200).
			composable shapes do: [:node | (node == boxProvidedParameters) ifTrue: [ toProvidedParameters add: node ]]].
		
			collection == toUsedParameters ifTrue: [ 
			composable position: (n*(70))@(n*(50) + 50).
			composable shapes do: [:node | (node == svgUsedParameters ) ifTrue: [ toUsedParameters add: node ]]].
		
			collection == toConsumedEvents ifTrue: [ 
			composable position: (50)+(n*(70))@(n*(50) - 30).
			composable shapes do: [:node | (node == svgConsumedEvents) ifTrue: [ toConsumedEvents add: node ]]].
		
			collection == toUsedServices ifTrue: [ 
			composable position: (50)+(n*(70))@(n*(50) - 150).
			composable shapes do: [:node | (node == svgUsedServices) ifTrue: [ toUsedServices add: node ]]].
			composable @ popup
		]).
	 ].
	^array
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

{ #category : #accessing }
SpMolShowComponent >> componentShape [
	^componentShape
]

{ #category : #accessing }
SpMolShowComponent >> componentShape: aComponent [
	componentShape := aComponent .
	componentShape
		position: 50@10;
		draggable;
		model: component;
		shapes: (self shapeModel: component) .
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> composable: aComposable shapes: aRSGroup [
	aComposable
		shapes: aRSGroup
		
]

{ #category : #initialization }
SpMolShowComponent >> configure: canvas [
	|  componentsInstances numbersOfComponentsInstances arrayOfUsedComponentServices  fromConsumedEvents  arrayOfConsumedComponentEvents arrayOfUsedComponentParameters fromUsedParameters   arrayOfProvidedComponentParameters fromProvidedParameters  arrayOfProducedComponentEvents  arrayOfProvidedComponentServices fromProvidedServices   fromProducedEvents  fromUsedServices |
	
	molContract := MolContract new.

	componentsInstances := component allSubInstances.
	numbersOfComponentsInstances := componentsInstances size.
	
	componentShape := RSComposite new.
	self componentShape: componentShape.
		
	fromUsedServices := (componentShape shapes shapesFromModel: (molContract usedServices: component))
	detect: [:svg | svg isKindOf: RSSVGPath ].
	fromConsumedEvents := (componentShape shapes shapesFromModel: (molContract consumedEvents: component))
	detect: [:svg | svg isKindOf: RSSVGPath ].
	fromUsedParameters := (componentShape shapes shapesFromModel: (molContract usedParameters: component))
	detect: [:svg | svg isKindOf: RSSVGPath ].
	fromProvidedParameters := (componentShape shapes shapesFromModel: (molContract providedParameters: component))
	detect: [:aBox | aBox isKindOf: RSBox ].
	fromProducedEvents := (componentShape shapes shapesFromModel: (molContract producedEvents: component))
	detect: [:aPolygon | aPolygon isKindOf: RSPolygon ].
	fromProvidedServices := (componentShape shapes shapesFromModel: (molContract providedServices: component))
	detect: [:ellipse | ellipse isKindOf: RSEllipse  ].
	
	toProducedEvents := OrderedCollection new.
	toProvidedServices := OrderedCollection new.
	toProvidedParameters := OrderedCollection new.
	toUsedParameters := OrderedCollection new.
	toConsumedEvents := OrderedCollection new.
	toUsedServices := OrderedCollection new.
	
	
	arrayOfUsedComponentServices := self arrayOfComponents: usedComponentServices 
	shape: ellipseProvidedServices collection: toProvidedServices.
	
	arrayOfConsumedComponentEvents := self arrayOfComponents: consumedComponentEvents 
	shape: polygonProducedEvents collection: toProducedEvents.
	
	arrayOfUsedComponentParameters := self arrayOfComponents: usedComponentParameters 
	shape: boxProvidedParameters collection: toProvidedParameters.
	
	arrayOfProvidedComponentParameters := self arrayOfComponents: providedComponentParameters 
	shape: svgUsedParameters collection: toUsedParameters.
	
	arrayOfProducedComponentEvents :=  self arrayOfComponents: producedComponentEvents 
	shape: svgConsumedEvents collection: toConsumedEvents.
	
	arrayOfProvidedComponentServices := self arrayOfComponents: providedComponentServices 
	shape: svgUsedServices collection: toUsedServices.
	
	
	lineUsedServices := self from: fromUsedServices to: toProvidedServices color: Color blue.
	lineConsumedEvents := self from: fromConsumedEvents to: toProducedEvents color: Color red.
	lineUsedParameters :=  self from: fromUsedParameters to: toProvidedParameters color: Color green.
	lineProvidedParameters := self from: fromProvidedParameters to: toUsedParameters color: Color pink.
	lineProducedEvents :=  self from: fromProducedEvents to: toConsumedEvents color: Color purple.
	lineProvidedServices := self from: fromProvidedServices to: toUsedServices color: Color orange.
	
	self popup: component.
	self legend: canvas.
	
	componentShape @ popup.
	canvas add: arrayOfUsedComponentServices ; add: arrayOfConsumedComponentEvents ; add: arrayOfUsedComponentParameters ; add: arrayOfProvidedComponentParameters ; add: arrayOfProducedComponentEvents ; add: arrayOfProvidedComponentServices ; add: componentShape; addAll:lineUsedServices ; addAll:lineConsumedEvents ; addAll: lineUsedParameters; addAll: lineProvidedParameters ; addAll: lineProducedEvents ; addAll: lineProvidedServices .
	canvas @ RSCanvasController.
	
	self canvas: canvas. 
	self event: componentShape.
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

{ #category : #accessing }
SpMolShowComponent >> event: aComponent [
	aComponent 
		when: RSMouseRightClick
		do: [ :evt | | molMenu |
				molMenu := MolMenu new.
				molMenu selectedComponent: aComponent model.
				molMenu open: molMenu. ].
	
	aComponent 
		when: RSMouseLeftClick  
		do: [ :evt | 
			| zoom | 
			zoom := RSMolZoomCanvas new. 
			zoom scale: aComponent.
			zoom scale > 3
				ifTrue:  [ zoom zoomOut: aComponent ]
				ifFalse: [ zoom zoomIn: aComponent ].
			 ].
]

{ #category : #'instance creation' }
SpMolShowComponent >> from: from to: to color: aColor [
	to isNotNil ifTrue: [ 
	^((1 to: to size) collect: [:n | 
			RSBezier new
					withBorderAttachPoint;
					from: from;
					borderColor: aColor;
					controlPointsController: RSVerticalCPAPController new;
					width: 0.5;
					to: (to at:n).
				]as:RSGroup).
		]
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
		
	svgRelationConsumedEvents := RSSVGPath new
		border: (RSBorder new color: Color red; width:1);
		svgPath: 'M 5 10 l 9 0';
		model: 'ConsumedEvents relation'.
		
	svgRelationProvidedParameters := RSSVGPath new
		border: (RSBorder new color: Color pink; width:1);
		svgPath: 'M 5 10 l 9 0';
		model: 'ProvidedParameters relation'.
		
	svgRelationUsedServices := RSSVGPath new
		border: (RSBorder new color: Color blue; width:1);
		svgPath: 'M 5 10 l 9 0';
		model: 'UsedServices relation'.
		
	svgRelationUsedParameters := RSSVGPath new
		border: (RSBorder new color: Color green; width:1);
		svgPath: 'M 5 10 l 9 0';
		model: 'UsedParameters relation'.
	
	svgRelationProducedEvents := RSSVGPath new
		border: (RSBorder new color: Color purple; width:1);
		svgPath: 'M 5 10 l 9 0';
		model: 'ProducedEvents relation'.
	
	svgRelationProvidedServices := RSSVGPath new
		border: (RSBorder new color: Color orange; width:1);
		svgPath: 'M 5 10 l 9 0';
		model: 'ProvidedServices relation'.
		
	boxProvidedParametersLegend := RSBox new
		color: Color white; borderColor: Color white; borderColor: Color black; model: 'ProvidedParameters'.
	self borderWith: boxProvidedParametersLegend.
	
	legend := MolLegend new. 
	legend legend: RSLegend new container: aCanvas items: {ellipseTypeLegend. ellipseProvidedServicesLegend. polygonProducedEventsLegend.boxProvidedParametersLegend. svgUsedServicesLegend.svgConsumedEventsLegend. svgUsedParametersLegend. svgRelationUsedServices.svgRelationConsumedEvents.svgRelationUsedParameters.svgRelationProvidedParameters.svgRelationProducedEvents.svgRelationProvidedServices} title: 'Shapes Legend' onDemand: 'Legend of components' .
	
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

{ #category : #'as yet unclassified' }
SpMolShowComponent >> popup: aComponent [

	molPopup := MolPopup new.
	popup := RSPopup new.
	molPopup popup: popup title: aComponent.
		
]

{ #category : #'as yet unclassified' }
SpMolShowComponent >> producedComponentEventsConnected: producedEvents [
	producedComponentEvents :=  producedEvents
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
		model: (molContract type: aComponent)
		translateTo: 0@(-35).
		ellipseType @ (self labeled).
	
	lineType := RSLine new.
	self line: lineType to: ellipseType.
	
	ellipseProvidedServices := RSEllipse new.
	self 
		shape: ellipseProvidedServices 
		color: Color white 
		model: (molContract providedServices: aComponent)
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
	polygonProducedEvents model: (molContract producedEvents: aComponent).
	polygonProducedEvents @ (self labeled).
	
	lineProducedEvents := RSLine new.
	self line: lineProducedEvents to: polygonProducedEvents.
		
	boxProvidedParameters := RSBox new.
	self
		shape: boxProvidedParameters 
		color: Color white 
		model: (molContract providedParameters: aComponent)
		translateTo: 15@35
		borderColor: Color black.
	self borderWith: boxProvidedParameters.
	boxProvidedParameters @ (self labeled).
	
	"ellipseLifeCycleComponent := RSEllipse new color: Color black; translateTo: 10@20; size: 5."
	
	lineProvidedParameters := RSLine new.
	self line: lineProvidedParameters to: boxProvidedParameters.
		
	svgUsedParameters := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -19 39 l 0 -7 l 9 0 l 0 7'.
	svgUsedParameters model: (molContract usedParameters: aComponent).
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
	svgUsedServices model: (molContract usedServices: aComponent).
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
	svgConsumedEvents model: (molContract consumedEvents: aComponent).
	svgConsumedEvents @ (self labeled).
	
	lineConsumedEvents := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -32 13 l 7 -3';
		yourself.
		
	^{box.lineType .ellipseType .componentImplementation.lineConsumedEvents.svgConsumedEvents.lineUsedParameters.svgUsedParameters.lineProvidedParameters.boxProvidedParameters.lineProducedEvents.polygonProducedEvents. lineProvidedServices.ellipseProvidedServices.lineUsedServices.svgUsedServices }
]

{ #category : #accessing }
SpMolShowComponent >> usedComponentParametersConnected: usedParameters [
	usedComponentParameters := usedParameters
]

{ #category : #accessing }
SpMolShowComponent >> usedComponentServicesConnected: usedServices [
	usedComponentServices := usedServices
]
