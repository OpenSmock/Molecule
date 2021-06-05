"
class to show all component instances
"
Class {
	#name : #SpMolShowComponentInstances,
	#superclass : #SpMolShowComponent,
	#instVars : [
		'componentInstances',
		'btnNext',
		'btnPrev',
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

{ #category : #initialization }
SpMolShowComponentInstances >> configure: canvas [
	| componentsShape listcomponentInstancesName  |
	
	molContract := MolContract new.
		
	listcomponentInstancesName := OrderedCollection new.
	componentInstances do: [ :item | listcomponentInstancesName add: item componentName ].
	
	self popup: component.
	
	componentsShape := ((1 to: componentInstances size) collect: [:n | 
			componentShape := RSComposite new.
			componentShape
				draggable;
				model: (componentInstances at:n);
				shapes: (self shapeModel: component instance: (componentInstances at:n)).
			componentShape position: (150*n)@(10).
			componentShape @ popup.
			
			componentShape 
				when: RSMouseRightClick
					do: [ :evt | | molMenu |
						molMenu := MolMenu new.
						molMenu selectedComponent: component.
						molMenu open: molMenu. ].
			
		]as:RSGroup).
	
	self legend: canvas.
	
	canvas addAll: componentsShape.
	canvas @ RSCanvasController.
	
	self canvas: canvas.
	
	labelInfosNbInst label: 'number of instances : ', self instances size asString.
	labelInfosListInst label: 'liste of instances implementation : ', self instances asString.
	labelInfosListInstName label: 'liste of instances name : ', listcomponentInstancesName asString.
	
	
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

	| ellipseComponentStart ellipseComponentStop |
	
	super legend:aCanvas.
	
	ellipseComponentStart := RSEllipse new 
		color: Color green; 
		 model: 'Instance start'.
	
	ellipseComponentStop := RSEllipse new 
		color: Color red; 
		 model: 'Instance stop'.
	
	legend items: {ellipseComponentStart. ellipseComponentStop}.
	
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
SpMolShowComponentInstances >> updateLabelName [
	^labelInfosName
		
]

{ #category : #updating }
SpMolShowComponentInstances >> updateLabelName: aString [
	labelInfosName
		label: 'name of instance : ', aString asString 
]
