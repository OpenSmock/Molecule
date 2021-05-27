"
Class for the component creation
"
Class {
	#name : #SpMolCreateComponent,
	#superclass : #SpMolShowComponent,
	#instVars : [
		'modelCanvas',
		'componentShapeNew',
		'boolean',
		'transformable',
		'label',
		'componentModelShape',
		'menu',
		'aMenu1'
	],
	#category : #'Molecule-IDE-Incubators'
}

{ #category : #specs }
SpMolCreateComponent class >> defaultSpec [ 
	^SpBoxLayout newLeftToRight 
		add: #modelCanvas withConstraints: [:c | c width: 250 ] ;
		add: #currentCanvas
	yourself.
]

{ #category : #'instance creation' }
SpMolCreateComponent class >> open [
	<script: 'self new openWithSpec'>
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> canvas: canvas create: aComponent [

canvas when: RSKeyDown do: 
	[  :evt | 
		(evt keyName == #A)
		ifTrue: [
			componentModelShape := RSComposite new.
			componentModelShape
				draggable;
				model: 'component';
				shapes: (self shapeModel).
			componentModelShape @ transformable.
			componentModelShape @ menu.
			
			self canvas: canvas delete: componentModelShape. 
			self canvas: canvas duplicate: componentModelShape.
			
			canvas add: componentModelShape.
			canvas signalUpdate ] ] .


]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> canvas: canvas delete: element [
element when: RSMouseLeftClick do:
[  :evt | transformable showHandles: evt.
	element when: RSKeyDown do: 
	[  :evt2 | (evt2 keyName == #D) | (evt2 keyName == #DELETE)
		ifTrue: [ transformable disableHandles: evt2. canvas removeShape: element. canvas signalUpdate ] ] ]
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> canvas: canvas duplicate: element [
|elementCopy |
element when: RSMouseLeftClick do:
[  :evt | transformable showHandles: evt.
	element when: RSKeyDown do: 
	[  :evt2 | 
		(evt2 keyName == #C)
		ifTrue: [
			elementCopy := element copy.
			elementCopy draggable.
			elementCopy position: element position + 50.
			
			elementCopy @ transformable.
			elementCopy @ menu.
			
			transformable showHandles: evt.
			
			self canvas: canvas duplicate: elementCopy.
			self canvas: canvas delete: elementCopy.

			canvas add: elementCopy. 
			canvas signalUpdate ] ] ].

]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> canvas: canvas from: from to: to line: line color: aColor pointX: aPoint [

|colorLine |

aColor == 1 ifTrue:[colorLine := Color blue].
aColor == 2 ifTrue:[colorLine := Color red].
aColor == 3 ifTrue:[colorLine := Color green].
aColor == 4 ifTrue:[colorLine := Color pink].
aColor == 5 ifTrue:[colorLine := Color purple].
aColor == 6 ifTrue:[colorLine := Color orange].
from
		color: colorLine;
		translateBy: -30 @ aPoint;
		draggable;
		size: 5.
		
to 
		color: colorLine;
		translateBy: 30 @ aPoint;
		size: 5.
		
line
	withBorderAttachPoint;
	borderColor: colorLine;
	from: from;
	to: to;
	draggable ;
	controlPointsController: RSVerticalCPAPController new;
	width: 0.5.

^{line.from.to} asGroup asShape
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> canvas: canvas transformable: aTransformable [
"à revoir"
componentShape when: RSMouseLeftClick do:
[  :evt | aTransformable showHandles: evt.
	componentShape when: RSKeyDown do: [  :evt2 | (evt2 keyName == #C)
		ifTrue: [ |componentShapeCopy|
			componentShapeCopy := componentShape copy.
			componentShapeCopy draggable.
			componentShapeCopy position: componentShape position + 50.
			componentShapeCopy @transformable.
			canvas add: componentShapeCopy.
			componentShape := componentShapeCopy ] ] ]
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> canvas: canvas transformable: aTransformable component: aComponent [
"à revoir"
aComponent when: RSMouseLeftClick do:
[  :evt | aTransformable showHandles: evt.
	aComponent when: RSKeyDown do: [  :evt2 | (evt2 keyName == #C)
		ifTrue: [ |componentShapeCopy|
			componentShapeCopy := componentShape copy.
			componentShapeCopy draggable.
			componentShapeCopy position: aComponent position + 50.
			componentShapeCopy @transformable.
			canvas add: componentShapeCopy.] ] ]
]

{ #category : #initialization }
SpMolCreateComponent >> configure: canvas [

"à revoir"

| line circle1 circle2 |

componentShape := RSComposite new.
componentShape
		isFixed: true;
    	position: 50@25;
		draggable;
		model: 'component';
		shapes: (self shapeModel).
		
"componentShapeNew := RSComposite new.
componentShapeNew
		position: 0@0;
		draggable;
		model: component;
		shapes: (super shapeModel: component)."
		
circle2 := RSEllipse new
		color: Color green;
		 translateBy: 150 @ 50;
		draggable;
		size: 10.
circle1 := RSEllipse new
		color: Color red;
		translateBy: 100 @ 50;
		size: 10.
		
line := RSBezier new
	withBorderAttachPoint;
	borderColor: Color green;
	from: circle1;
	to: circle2;
	draggable ;
	controlPointsController: RSVerticalCPAPController new;
	width: 0.5.
	

transformable := RSMolTransformable new.


componentShape when: RSMouseDragStart do: 
[ canvas  add: componentShape copy.].


componentShape when: RSMouseDragEnd do: 
[ :evt |
	transformable showHandles: evt.
	componentShapeNew := RSComposite new.
	componentShapeNew
		draggable;
		model: 'component';
		shapes: (self shapeModel).
	componentShapeNew position: componentShape position.
	componentShapeNew @ transformable.
	canvas  add: componentShapeNew .
	canvas  removeShape: componentShape .
	self configure: canvas
	"componentShape @ transformable" ].
	
	
canvas  add: componentShape .
canvas add: circle1 ; add: circle2 ; add: line .
canvas @ RSCanvasController.
]

{ #category : #initialization }
SpMolCreateComponent >> configure: canvas boolean: aBoolean [

"à revoir"

| line circle1 circle2 |

boolean := aBoolean. 

componentShape := RSComposite new.
componentShape
		position: 0@0;
		draggable;
		model: 'component';
		shapes: (self shapeModel).
		
circle2 := RSEllipse new
		color: Color green;
		 translateBy: 50 @ 50;
		draggable;
		size: 10.
circle1 := RSEllipse new
		color: Color red;
		translateBy: 100 @ 50;
		size: 10.
		
line := RSBezier new
	withBorderAttachPoint;
	borderColor: Color green;
	from: circle1;
	to: circle2;
	draggable ;
	controlPointsController: RSVerticalCPAPController new;
	width: 0.5.
	

transformable := RSMolTransformable new.


componentShape when: RSMouseDragEnd do: 
[ :evt |transformable showHandles: evt.
	componentShapeNew := RSComposite new.
	componentShapeNew
		draggable;
		model: 'component';
		shapes: (self shapeModel).
	componentShapeNew position: componentShape position.
	componentShapeNew @ transformable.
	canvas  add: componentShapeNew .
	self canvas: canvas transformable: transformable component: componentShapeNew. 
	canvas  removeShape: componentShape ].


componentShape when: RSMouseDragStart do: 
[canvas  add: componentShape copy. ].


boolean == false ifTrue: [ canvas  add: componentShape . ].

canvas add: circle1 ; add: circle2 ; add: line .

"canvas camera scale: 0.5.
canvas camera position extent: 10000@10000.
canvas camera zoomToFit: canvas extent * 0.9."

canvas @ RSCanvasController.

"canvas zoomToFit."
]

{ #category : #initialization }
SpMolCreateComponent >> connectPresenters [

currentCanvas script: [ :canvas |
		self create: canvas. 
		self legendShape: canvas.
		"self configure: canvas boolean:false." ].
	
modelCanvas script: [ :canvas |
		self model:canvas .
		self legendModel: canvas. ].
]

{ #category : #tests }
SpMolCreateComponent >> create: canvas [

canvas when: RSMouseRightClick do: [ 
		:evt | 
		| molCreateComponentMenu |

		componentModelShape := RSComposite new.
		componentModelShape
				draggable;
				model: 'component';
				shapes: (self shapeModel).
		componentModelShape @ transformable.
		
		label := RSLabel new.
		label
			draggable;
			model: 'label';
			text: 'Text here'.
		label @ transformable.
		
		molCreateComponentMenu := MolCreateComponentMenu new.
		molCreateComponentMenu canvas: canvas.
		molCreateComponentMenu componentShape: componentModelShape.
		molCreateComponentMenu label: label.
		molCreateComponentMenu open: molCreateComponentMenu.
		
		self canvas: canvas delete: componentModelShape. 
		self canvas: canvas duplicate: componentModelShape.
		
		componentModelShape @ menu.
		label @ menu.
		
		self canvas: canvas delete: label. 
		self canvas: canvas duplicate: label.
		
		].

canvas when: RSKeyDown do: 
[  :evt | 
	(evt keyName == #T)
		ifTrue: [
			label := RSLabel new.
			label
				draggable;
				model: 'label';
				text: 'Text here'.
			label @ transformable.
			
			self canvas: canvas delete: label. 
			self canvas: canvas duplicate: label.
			
			label @ menu.
			canvas add: label.
			canvas signalUpdate 
	] .
	(evt keyName == #A)
		ifTrue: [
		componentModelShape := RSComposite new.
		componentModelShape
				draggable;
				model: 'component';
				shapes: (self shapeModel).
		componentModelShape @ transformable.
		
			self canvas: canvas delete: componentModelShape. 
			self canvas: canvas duplicate: componentModelShape.
			
			componentModelShape @ menu.
			canvas add: componentModelShape.
			canvas signalUpdate.
	]] .

canvas @RSCanvasController .
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> initialize [ 
	super initialize.
	
	transformable := RSMolTransformable new.
	menu := RSMenuActivable new.
	self menu.

]

{ #category : #initialization }
SpMolCreateComponent >> initializePresenters [
	currentCanvas := self instantiate: SpRoassalPresenter.
	modelCanvas := self instantiate: SpRoassalPresenter.
	
]

{ #category : #initialization }
SpMolCreateComponent >> initializeWindow: aWindowPresenter [

aWindowPresenter
	title: 'Create Component';
	initialExtent: 1200@700.
			
		
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> legendModel: canvas [

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
		
	label := RSLabel new
		text: 'text';
		model: 'Label'.
		
	componentModelShape := RSComposite new.
	componentModelShape
		model: 'component';
		shapes: (self shapeModel).
	
	legend := MolLegend new. 
	legend legend: RSLegend new container: canvas items: {.svgRelationConsumedEvents.svgRelationUsedParameters.svgRelationProvidedParameters.svgRelationProducedEvents.svgRelationProvidedServices.label.componentModelShape } title: 'Legend' onDemand: 'Legend of drawing' .
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> legendShape: aCanvas [
	
	|labelCopy labelDelete legendShape |
	
	labelCopy := RSLabel new.
	labelCopy text: 'Select an element and Press C to copy'.
	
	labelDelete := RSLabel new.
	labelDelete text: 'Select an element and Press D or SUPPR to delete'.
	
	legendShape := MolLegend new.
	legendShape legend: RSLegend new container: aCanvas items: {labelCopy.labelDelete} title: 'Help Keyboard' onDemand: 'Legend of Keyboard tools' .
]

{ #category : #accessing }
SpMolCreateComponent >> menu [
	menu menuDo: [ :aMenu :target | 
			aMenu 
				add: 'copy' 
				target: target 
				selector: #value
				iconName: 'smallCopy'.
			aMenu
				add: 'cut' 
				target: target
				selector: #value 
				iconName: 'smallCut'.
			
			aMenu
				add: 'delete' 
				target: target
				selector: #value
				iconName: 'smallDelete'.
			
			aMenu addSeparator.
			
			aMenu 
				add: 'inspect' 
				target: target 
				selector: #inspect
				iconName: 'glamorousInspect'.

			].
	
]

{ #category : #tests }
SpMolCreateComponent >> model: canvas [
| lines popupComponent popupLabel popupLine|

popupComponent := RSPopup new.
self popup: popupComponent touch: 'A' element: 'a component'. 

componentModelShape := RSComposite new.
componentModelShape
		model: 'component';
		shapes: (self shapeModel).

componentModelShape @ popupComponent.

popupLine := RSPopup new.
self popup: popupLine touch: 'R' element: 'a relation'. 

lines := RSComposite new.
lines shapes: ((1 to: 6) collect: [ :n |
		|  from to line |
		from := RSEllipse new.	
		to := RSEllipse new.	
		line := RSBezier new.
		self canvas: canvas from: from to: to line: line color: n pointX: (n*15)+50 ]).

lines @ popupLine.

popupLabel := RSPopup new.
self popup: popupLabel touch: 'T' element: 'a label'. "T suche as Text"

label := RSLabel new
		fontSize: 10;
		position: 0@(-70);
		text: 'Text'.

label @ popupLabel.

canvas  add: componentModelShape ; add: label; add: lines.
canvas color: 'E0E0E0'.
canvas @ RSCanvasController.
]

{ #category : #accessing }
SpMolCreateComponent >> popup: aPopup touch: touch element: element [

	| labelkeyBoard labelMenu |

	labelkeyBoard := RSLabel new.
	labelkeyBoard model: 'press ', touch, ' to create ', element. 

	labelMenu := RSLabel new.
	labelMenu model: 'right click to access on menu'.

	molPopup := MolPopup new.
	molPopup popup: aPopup title: element, ' on drawing place' items: {labelkeyBoard. labelMenu}.
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> shapeModel [

	componentImplementation := RSLabel new
			fontSize: 1.5;
			model: 'implementation'
			yourself.
	
	self box: self box.
	self borderWith: box.
	
	ellipseType := RSEllipse new.
	self 
		shape: ellipseType
		color: Color black 
		model: 'type'
		translateTo: 0@(-35).
		ellipseType @ (self labeled).
	
	lineType := RSLine new.
	self line: lineType to: ellipseType.
	
	ellipseProvidedServices := RSEllipse new.
	self 
		shape: ellipseProvidedServices 
		color: Color white 
		model: 'providedServices'
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
	polygonProducedEvents model: 'producedEvents'.
	polygonProducedEvents @ (self labeled).
	
	lineProducedEvents := RSLine new.
	self line: lineProducedEvents to: polygonProducedEvents.
		
	boxProvidedParameters := RSBox new.
	self
		shape: boxProvidedParameters 
		color: Color white 
		model: 'providedParameters'
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
	svgUsedParameters model: 'usedParameters'.
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
	svgUsedServices model: 'usedServices'.
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
	svgConsumedEvents model: 'consumedEvents'.
	svgConsumedEvents @ (self labeled).
	
	lineConsumedEvents := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -32 13 l 7 -3';
		yourself.
		
	^{box.lineType .ellipseType .componentImplementation.lineConsumedEvents.svgConsumedEvents.lineUsedParameters.svgUsedParameters.lineProvidedParameters.boxProvidedParameters.lineProducedEvents.polygonProducedEvents. lineProvidedServices.ellipseProvidedServices.lineUsedServices.svgUsedServices }
	
	
]
