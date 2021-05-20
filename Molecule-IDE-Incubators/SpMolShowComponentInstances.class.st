"
class to show all component instances
"
Class {
	#name : #SpMolShowComponentInstances,
	#superclass : #SpMolShowComponent,
	#instVars : [
		'fromUsedServices',
		'componentInstances',
		'btnNext',
		'btnPrev',
		'indexInstances',
		'labelInfosName',
		'labelInfosListInst',
		'labelInfosNbInst',
		'labelInfosListInstName'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #specs }
SpMolShowComponentInstances class >> defaultSpec [
	<spec: #default>
	^ SpBoxLayout newVertical
	add: (SpBoxLayout newHorizontal 
	"add: #btnPrev withConstraints: [ :c | c height: 10 ];"
	add: #currentCanvas) ;
	"add: #btnNext withConstraints: [ :c | c height: 10 ]);"
	add: #labelInfosName withConstraints: [ :c | c height: 40 ; padding: 10 ];
	add: #labelInfosNbInst withConstraints: [ :c | c height: 40 ; padding: 5 ];
	add: #labelInfosListInst withConstraints: [ :c | c height: 40 ; padding: 5 ];
	add: #labelInfosListInstName withConstraints: [ :c | c height: 40 ; padding: 5 ];
	yourself.
]

{ #category : #specs }
SpMolShowComponentInstances class >> open [
	<script: 'self new openWithSpec'>
]

{ #category : #accessing }
SpMolShowComponentInstances >> canvas: aCanvas [
	| nodesSize current buttons |

	nodesSize := aCanvas nodes size.
	current := 0.
	buttons := {
	'Previous'	-> [ (current - 1) < 1 ifTrue: [ nodesSize ] ifFalse: [ current - 1 ] ].
	'Next' 	-> [ current % nodesSize + 1 ].	
	} collect: [ :asso |
	| box1 label1 button |
	box1 := RSBox new
		color: Color white;
		withBorder;
		cornerRadius: 5;
		extent: 75@25;
		yourself.
	label1 := RSLabel new 
		text: asso key;
		color: Color black;
		yourself.
		button := { box1. label1 } asGroup asShape
		isFixed: true;
		when: RSMouseEnter do: [ box1 color: Color lightBlue; signalUpdate ];
		when: RSMouseLeave do: [ box1 color: Color white; signalUpdate ];
		when: RSMouseClick do: [ 
			aCanvas newAnimation
				duration: 200 milliSeconds;
				scale: (NSScale linear
					domain: #(0 0.5 1);
					range: {'lightBlue'. Color lightGray darker. 'lightBlue'.});
				on: box1 set: #color:.
			 ];
		when: RSMouseClick do: [
			| camera fscale fpos tscale tpos node|
			
			current := asso value value.
			node := aCanvas nodes at: current.
			
			camera := aCanvas camera.
			fscale := camera scale.
			fpos := camera position.
			camera
				zoomToFit: aCanvas extent * 0.9 
				rectangle: node encompassingRectangle.
			
			tscale := camera scale.
			tpos := camera position.
			
			aCanvas newAnimation
				duration: 1 second;
				easing: RSEasing circleOut;
				onStepDo: [ :t | 
					
					self updateLabelName: (componentInstances at: current) componentName.
					camera
						scale: (fscale interpolateTo: tscale at: t);
						position: (fpos interpolateTo: tpos at: t).
					aCanvas signalUpdate.
					 ]
			].
] as: RSGroup.
	
RSHorizontalLineLayout on: buttons.
buttons translateBy: 5.
aCanvas addAll: buttons.
]

{ #category : #accessing }
SpMolShowComponentInstances >> canvas: aCanvas btn: btn [
	| nodesSize current asso |

	"à revoir"
	
	nodesSize := aCanvas nodes size.
	current := 0.
	btn == btnPrev ifTrue: [ asso := [ (current - 1) < 1 ifTrue: [ nodesSize ] ifFalse: [ current - 1 ] ] ].
	btn == btnNext ifTrue: [ asso := [ current % nodesSize + 1 ] ].
	"buttons := {
	'Previous'	-> [ (current - 1) < 1 ifTrue: [ nodesSize ] ifFalse: [ current - 1 ] ].
	'Next' 	-> [ current % nodesSize + 1 ].	
	} collect: [ :asso |"
		
	btnNext	action: [
			| camera1 fscale fpos tscale tpos node|
			current := asso value value.
			node := aCanvas nodes at: current.
			
			camera1 := aCanvas camera.
			fscale := camera1 scale.
			fpos := camera1 position.
			camera1
				zoomToFit: aCanvas extent * 0.9 
				rectangle: node encompassingRectangle.
			
			tscale := camera1 scale.
			tpos := camera1 position.
			
			aCanvas newAnimation
				duration: 1 second;
				easing: RSEasing circleOut;
				onStepDo: [ :t | 
					camera1 
						scale: (fscale interpolateTo: tscale at: t);
						position: (fpos interpolateTo: tpos at: t).
					aCanvas signalUpdate.
					 ]
			].
]

{ #category : #initialization }
SpMolShowComponentInstances >> configure: canvas [
	| componentsShape labelName labelNbInst labelListInst  labelsNbInst labelsName labelsListInst listcomponentInstancesName  |
	
	molContract := MolContract new.
	"componentInstances := component allSubInstances.
	numbersOfComponentsInstances := componentInstances size.
	
	componentInstances isEmpty 
		ifTrue:[SpMolModalPresenter new openModalWithSpec.]."
		
	listcomponentInstancesName := OrderedCollection new.
	componentInstances do: [ :item | listcomponentInstancesName add: item componentName ].
	
	self popup: component.
	componentsShape := ((1 to: componentInstances size) collect: [:n | 
			componentShape := RSComposite new.
			componentShape
				draggable;
				model: (componentInstances at:n);
				shapes: (self shapeModel: component instance: (componentInstances at:n)).
			componentShape @ popup.
			componentShape position: (150*n)@(10).
			
			componentShape 
				when: RSMouseRightClick
					do: [ :evt | | molMenu |
						molMenu := MolMenu new.
						molMenu selectedComponent: component.
						molMenu open: molMenu. ].
			
		]as:RSGroup).

	labelsNbInst := ((1 to: componentInstances size) collect: [:n | 
			labelNbInst := RSLabel new.
			labelNbInst text: ('nombre d''instances : ', componentInstances size asString) ; position: 180*n@60.
			labelNbInst fontSize: 2.5.
			labelNbInst color: '35978F'.
		]as:RSGroup).
	
	labelsName  := ((1 to: componentInstances size) collect: [:n | 
			labelName := RSLabel new.
			labelName text: ('nom de l''instance actuelle : ', 'nom') ; position: 130*n@60.
			labelName fontSize: 2.5.
			labelName color: '01665E'.
		]as:RSGroup).
	
	labelsListInst  := ((1 to: componentInstances size) collect: [:n | 
			labelListInst := RSLabel new.
			labelListInst text: ('liste des instances : ', componentInstances asString) ; position: 150*n@70.
			labelListInst fontSize: 2.5.
			labelListInst color: '003C30'.
		]as:RSGroup).
	
	self legend: canvas.
	
	componentShape @ popup.
	canvas addAll: componentsShape.
	canvas @ RSCanvasController.
	
	self canvas: canvas.
	
	labelInfosNbInst label: 'number of instances : ', self instances size asString.
	labelInfosListInst label: 'liste of instances implementation : ', self instances asString.
	labelInfosListInstName label: 'liste of instances name : ', listcomponentInstancesName asString.
	
	"btnNext action: [ self canvas: canvas btn: btnNext. ].
	btnPrev action: [ self canvas: canvas btn: btnPrev. ]."
	
]

{ #category : #'as yet unclassified' }
SpMolShowComponentInstances >> initialize [
	super initialize.
	
	
	
	
	
]

{ #category : #initialization }
SpMolShowComponentInstances >> initializePresenters [
	currentCanvas := self instantiate: SpRoassalPresenter.
	
	btnNext := self newButton.
	btnNext icon: ((self iconNamed: #glamorousRight) scaledToSize: 30 @ 30).
	
	btnPrev := self newButton.
	btnPrev icon: ((self iconNamed: #glamorousLeft) scaledToSize: 30 @ 30).
	
	labelInfosName := self newLabel.
	labelInfosListInst := self newLabel.
	labelInfosNbInst := self newLabel.
	labelInfosListInstName := self newLabel.
	
	
	

]

{ #category : #initialization }
SpMolShowComponentInstances >> initializeWindow: aWindowPresenter [

aWindowPresenter
	title: ('Show instances of ', self component asString);
	initialExtent: 1000@700.
]

{ #category : #accessing }
SpMolShowComponentInstances >> instances [
	^componentInstances
]

{ #category : #'as yet unclassified' }
SpMolShowComponentInstances >> instances: aComponentInstance [
	componentInstances := aComponentInstance
]

{ #category : #'as yet unclassified' }
SpMolShowComponentInstances >> legend: aCanvas [

	| ellipseComponentStart ellipseComponentStop legendShape |
	
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
	
	ellipseComponentStart := RSEllipse new 
		color: Color green; 
		 model: 'Instance start'.
	
	ellipseComponentStop := RSEllipse new 
		color: Color red; 
		 model: 'Instance stop'.
	
	legendShape := MolLegend new.
	legendShape legend: RSLegend new container: aCanvas items: {ellipseTypeLegend. ellipseProvidedServicesLegend. polygonProducedEventsLegend.boxProvidedParametersLegend.svgUsedServicesLegend.svgConsumedEventsLegend. svgUsedParametersLegend. ellipseComponentStart. ellipseComponentStop} title: 'Shapes Legend' onDemand: 'Legend of components' .
	
]

{ #category : #'as yet unclassified' }
SpMolShowComponentInstances >> shapeModel: aComponent instance: instance [
	
	| componentInstance ellipseLifeCycleComponent |
		
	super shapeModel: aComponent.
		
	componentInstance := RSLabel new
			fontSize: 2;
			model: 'name of instance : ', instance componentName asString;
			position: 0@10;
			color: 'F0027F';
			yourself.
	
	ellipseLifeCycleComponent := RSEllipse new translateTo: 20@20; size: 4.
	ellipseLifeCycleComponent 
		color: (instance componentConnector ifNotNil: [ Color green ] ifNil: [ Color red ] ).
		"à améliorer => mettre la bonne condition"
	
	^{box.lineType .ellipseType .componentImplementation.componentInstance.lineConsumedEvents.svgConsumedEvents.lineUsedParameters.svgUsedParameters.lineProvidedParameters.boxProvidedParameters.lineProducedEvents.polygonProducedEvents. lineProvidedServices.ellipseProvidedServices.lineUsedServices.svgUsedServices.ellipseLifeCycleComponent }
]

{ #category : #updating }
SpMolShowComponentInstances >> updateLabel [
	^labelInfosName
		
]

{ #category : #updating }
SpMolShowComponentInstances >> updateLabel: aString [
	labelInfosName
		label: 'name of instance : ', aString asString 
]

{ #category : #updating }
SpMolShowComponentInstances >> updateLabelName [
	^labelInfosName
		
]

{ #category : #updating }
SpMolShowComponentInstances >> updateLabelName: aString [
	labelInfosName
		label: 'name of instance : ', aString asString 
]
