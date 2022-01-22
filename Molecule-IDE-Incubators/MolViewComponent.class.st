"
This is the component element for Molecule View.

"
Class {
	#name : #MolViewComponent,
	#superclass : #MolViewElement,
	#instVars : [
		'component',
		'cin',
		'cout'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #accessing }
MolViewComponent >> cin [
	^ cin
]

{ #category : #accessing }
MolViewComponent >> component [
	^component.
]

{ #category : #initialization }
MolViewComponent >> component: aComponent [ 
	component := aComponent.
]

{ #category : #accessing }
MolViewComponent >> cout [
	^ cout
]

{ #category : #initialization }
MolViewComponent >> createConnectorInPara: inParameters inEvents: inEvents inServices: inServices [
	"add the view connectors in to the view component"
	inParameters do: [ :parameter | cin add: (MolViewConnectorIn new fromParameter: parameter) ].
	inEvents do: [ :event | cin add: (MolViewConnectorIn new fromEvent: event) ].
	inServices do: [ :service | cin add: (MolViewConnectorIn new fromService: service) ].
]

{ #category : #initialization }
MolViewComponent >> createConnectorOutPara: outParameters outEvents: outEvents outServices: outServices [
	"add the view connectors in to the view component"
	outParameters do: [ :parameter | cout add: (MolViewConnectorOut new fromParameter: parameter) ].
	outEvents do: [ :event | cout add: (MolViewConnectorOut new fromEvent: event) ].
	outServices do: [ :service | cout add: (MolViewConnectorOut new fromService: service) ].
]

{ #category : #'as yet unclassified' }
MolViewComponent >> drawConnectorsIn [
	| panel |
	panel := RSComposite new.
	self cin do: [ :each | panel add: (each rsobject)].
	RSVerticalLineLayout new alignLeft on: panel nodes.
	panel adjustToChildren.
	^ panel.
]

{ #category : #'as yet unclassified' }
MolViewComponent >> drawConnectorsOut [
	| panel |
	panel := RSComposite new.
	self cout do: [ :each | panel add: (each rsobject)].
	RSVerticalLineLayout new alignRight on: panel nodes.
	panel adjustToChildren.
	^ panel.
]

{ #category : #'as yet unclassified' }
MolViewComponent >> drawLabel [
	^RSLabel new
			color: (Color black);
			fontName: 'Source Sans Pro';
			fontSize: 20;
			text: ((MolUtils componentType: (self component)) asString);
			yourself.
]

{ #category : #layouts }
MolViewComponent >> drawRsObject [
	| panelLabel panelBoth panelIn panelOut |
	rsobject := RSComposite new.
	panelBoth := RSComposite new.
	
	panelIn := self drawConnectorsIn.
	panelOut := self drawConnectorsOut.
	panelBoth add: panelIn ; add: panelOut.
	RSHorizontalLineLayout new alignTop on: panelBoth nodes.
	panelBoth adjustToChildren.
	
	panelLabel := RSComposite new.
	panelLabel add: (self drawLabel).
	panelLabel adjustToChildren.

	rsobject add: panelLabel ; add: panelBoth.
	RSVerticalLineLayout new alignCenter on: rsobject nodes.
	rsobject adjustToChildren.
	rsobject border: (RSBorder new
				width: 1;
				color: (Color black)).
	
	^rsobject.
]

{ #category : #initialization }
MolViewComponent >> initialize [ 
	super initialize.
	cin := LinkedList new.
	cout := LinkedList new.
]

{ #category : #initialization }
MolViewComponent >> initializeComponent: aComponent [ 
	self component: aComponent.
	self initializeConnectors: aComponent.
	self drawRsObject.
]

{ #category : #initialization }
MolViewComponent >> initializeConnectors: aComponent [
	"create array for in and out connector for the parameters, the events, and the services"	
	| inParameters inEvents inServices outParameters outEvents outServices |
	inParameters := MolUtils usedComponentParameters: aComponent.
	inEvents := MolUtils consumedComponentEvents: aComponent.
	inServices := MolUtils usedComponentServices: aComponent.
	self createConnectorInPara: inParameters inEvents: inEvents inServices: inServices.

	outParameters := MolUtils providedComponentParameters: aComponent.
	outEvents := MolUtils producedComponentEvents: aComponent.
	outServices := MolUtils providedComponentServices: aComponent.
	self createConnectorOutPara: outParameters outEvents: outEvents outServices: outServices.
]

{ #category : #deprecated }
MolViewComponent >> scriptTest [
	<script: '(self new initializeComponent: (MolMyAlarmComponentImpl new)) scriptTest open.'>
	| c |
	c := RSCanvas new.
	c add: self drawRsObject.
	c @ RSCanvasController.
	c zoomToFit.
	^ c
]
