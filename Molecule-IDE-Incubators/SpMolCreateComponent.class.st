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
		'menu'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
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
			self componentModelShape.
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

{ #category : #accessing }
SpMolCreateComponent >> componentModelShape [
componentModelShape := RSComposite new.
		componentModelShape
				draggable;
				model: 'component';
				shapes: (self shapeModel).
		componentModelShape @ transformable.
]

{ #category : #initialization }
SpMolCreateComponent >> connectPresenters [

currentCanvas script: [ :canvas |
		self create: canvas. 
		self legendShape: canvas. ].
	
modelCanvas script: [ :canvas |
		self model:canvas .
		self legendModel: canvas. ].
]

{ #category : #tests }
SpMolCreateComponent >> create: canvas [

canvas when: RSMouseRightClick do: [ 
		:evt | 
		| molCreateComponentMenu |

		self componentModelShape.
		self label.
		
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
			self label.
			
			self canvas: canvas delete: label. 
			self canvas: canvas duplicate: label.
			
			label @ menu.
			canvas add: label.
			canvas signalUpdate 
	] .
	(evt keyName == #A)
		ifTrue: [
			self componentModelShape.
		
			self canvas: canvas delete: componentModelShape. 
			self canvas: canvas duplicate: componentModelShape.
			
			componentModelShape @ menu.
			canvas add: componentModelShape.
			canvas signalUpdate.
	]] .

canvas @RSCanvasController.
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

{ #category : #accessing }
SpMolCreateComponent >> label [
	label := RSLabel new.
	label
		draggable;
		model: 'label';
		text: 'Text here'.
	label @ transformable.
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> legendModel: canvas [
		
	label := RSLabel new
		text: 'text';
		model: 'Label'.
		
	componentModelShape := RSComposite new.
	componentModelShape
		model: 'component';
		shapes: (self shapeModel).
	
	legend := MolLegend new. 
	legend container: canvas items: {label.componentModelShape } title: 'Legend' onDemand: 'Legend of drawing' .
	super addRelationLegend: canvas.
]

{ #category : #'as yet unclassified' }
SpMolCreateComponent >> legendShape: aCanvas [
	
	|labelCopy labelDelete legendShape |
	
	labelCopy := RSLabel new.
	labelCopy text: 'Select an element and Press C to copy'.
	
	labelDelete := RSLabel new.
	labelDelete text: 'Select an element and Press D or SUPPR to delete'.
	
	legendShape := MolLegend new.
	legendShape container: aCanvas items: {labelCopy.labelDelete} title: 'Help Keyboard' onDemand: 'Legend of Keyboard tools' .
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

	self componentImplementation: 'implementation'.
	
	self box: self box.
	self borderWith: box.
	
	self ellipseType: 'type'.
	
	lineType := RSLine new.
	self line: lineType to: ellipseType.
	
	self ellipseProvidedServices: 'providedServices'.
	
	lineProvidedServices := RSLine new.
	self line: lineProvidedServices to: ellipseProvidedServices.
		
	self polygonProducedEvents: 'producedEvents'.
	
	lineProducedEvents := RSLine new.
	self line: lineProducedEvents to: polygonProducedEvents.
		
	self boxProvidedParameters: 'providedParameters'.
	
	lineProvidedParameters := RSLine new.
	self line: lineProvidedParameters to: boxProvidedParameters.
		
	self svgUsedParameters: 'usedParameters'.
	
	lineUsedParameters := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -13 25 l -3 7';
		yourself.
		
	self svgUsedServices: 'usedServices'.
	
	lineUsedServices := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -32 -16 l 7 3';
		yourself.
		
	self svgConsumedEvents: 'consumedEvents'.
	
	lineConsumedEvents := RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color black; width:0.5);
		svgPath: 'M -32 13 l 7 -3';
		yourself.
		
	^{box.lineType .ellipseType .componentImplementation.lineConsumedEvents.svgConsumedEvents.lineUsedParameters.svgUsedParameters.lineProvidedParameters.boxProvidedParameters.lineProducedEvents.polygonProducedEvents. lineProvidedServices.ellipseProvidedServices.lineUsedServices.svgUsedServices }
	
	
]
