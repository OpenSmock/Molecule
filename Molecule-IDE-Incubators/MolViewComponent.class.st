"
This is the component element for Molecule View.

- cin: contains all the in connexions
- cout: contains all the out connexions

To initialize do `MolViewComponent new initializeComponent: #yourComponent#`.

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

{ #category : #'instance creation' }
MolViewComponent class >> new: aComponent from: aSpace [
	| component |
	component := MolViewComponent new.
	component component: aComponent.
	component initializeVariables.
	component initializeSpace: aSpace.
	component initializeConnectors: aComponent.
	component drawMain.
	component initializeInteractions.
	^component.
]

{ #category : #colors }
MolViewComponent >> backgroundColor [
	^self theme componentBackground.
]

{ #category : #coloring }
MolViewComponent >> changePortsColor: aColor [ 
	cin do: [ :connector | connector changePortColor: aColor ].
	cout do: [ :connector | connector changePortColor: aColor ].
]

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
MolViewComponent >> componentName [
	^(MolUtils componentType: (self component)) asString.
]

{ #category : #accessing }
MolViewComponent >> cout [
	^ cout
]

{ #category : #drawing }
MolViewComponent >> drawConnectors: aCollection withLayout: aLayout [
	| panel |
	panel := RSComposite new.
	aCollection collect: [ :each | each rsobject] thenDo: [ :connector | panel add: connector ].

	"this is to add a small ammount of padding"
	panel add: (RSBox new extent: (0@0); color: Color transparent).

	aLayout on: panel nodes.
	panel adjustToChildren.
	^ panel.
]

{ #category : #drawing }
MolViewComponent >> drawLabel [
	| panelLabel |
	panelLabel := RSComposite new.
	panelLabel add: (RSLabel new
			color: (Color black);
			fontName: 'Source Sans Pro';
			fontSize: 20;
			text: self componentName;
			yourself).
	panelLabel adjustToChildren.
	^panelLabel.
]

{ #category : #drawing }
MolViewComponent >> drawMain [
	| panelLabel panelInOut panelInOutGap |

	rsobject := (RSComposite new 
		paint: self backgroundColor;
		border: (RSBorder new
			width: 1;
			color: (Color black));
		yourself).

	panelInOutGap := RSBox new extent: (0@0); color: Color transparent; yourself.
	panelInOut := self drawPanelConnectors: panelInOutGap.
	panelLabel := self drawLabel.
	
	"if label width > connectors panel width : we increase the gap between the connectors in and out"
	((panelLabel width) > (panelInOut width)) ifTrue: [ 
		panelInOutGap width: (panelLabel width - panelInOut width). 
		RSHorizontalLineLayout new alignTop on: panelInOut nodes.
		panelInOut adjustToChildren ].
	
	rsobject add: panelLabel ; add: panelInOut.
	RSVerticalLineLayout new alignCenter on: rsobject nodes.
	rsobject adjustToChildren.
	^rsobject.
]

{ #category : #drawing }
MolViewComponent >> drawPanelConnectors: aRSBoxForGap [
	"draw the panel containing the MolViewConnectors."
	| panelIn panelOut panelInOut |
	panelInOut := RSComposite new.
	
	panelIn := self drawConnectors: cin withLayout: (RSVerticalLineLayout new alignLeft).
	panelOut := self drawConnectors: cout withLayout: (RSVerticalLineLayout new alignRight).
	panelInOut add: panelIn ; add: aRSBoxForGap ; add: panelOut.
	RSHorizontalLineLayout new alignTop on: panelInOut nodes.
	panelInOut adjustToChildren.
	^panelInOut.
]

{ #category : #colors }
MolViewComponent >> highlightColor [
	^self theme componentHighLight.
]

{ #category : #interactions }
MolViewComponent >> highlightInPortIfConnect: aConnector [
	"hightlight in port -> trigger the hightlight on out port"
	cout select: [ :connector | connector canConnectWith: aConnector ] thenDo: [ :connector | connector highlightPort ].
]

{ #category : #interactions }
MolViewComponent >> highlightOutPortIfConnect: aConnector [
	"hightlight out port -> trigger the hightlight on in port"
	cin select: [ :connector | connector canConnectWith: aConnector ] thenDo: [ :connector | connector highlightPort ].
]

{ #category : #initialization }
MolViewComponent >> initialize [
	| interaction |
	super initialize.
	"cin := LinkedList new.
	cout := LinkedList new.
	rsobject := (RSComposite new 
		paint: self backgroundColor;
		border: (RSBorder new
			width: 1;
			color: (Color black));
		yourself).
	interaction := RSHighlightable new.
	interaction highlightBorder: (RSBorder new width: 5; color: Color blue translucent).
	rsobject @ interaction."
	
	
]

{ #category : #initialization }
MolViewComponent >> initializeComponent: aComponent [ 
	self component: aComponent.
	self initializeConnectors: aComponent.
	self drawMain.
]

{ #category : #initialization }
MolViewComponent >> initializeConnectors: aComponent [
	"create MolViewConnector for in and out for the parameters, the events, and the services"	
	| inParameters inEvents inServices outParameters outEvents outServices |
	inParameters := MolUtils usedComponentParameters: aComponent.
	inEvents := MolUtils consumedComponentEvents: aComponent.
	inServices := MolUtils usedComponentServices: aComponent.
	self initializeConnectors: cin class: MolViewConnectorIn parameters: inParameters events: inEvents services: inServices.

	outParameters := MolUtils providedComponentParameters: aComponent.
	outEvents := MolUtils producedComponentEvents: aComponent.
	outServices := MolUtils providedComponentServices: aComponent.
	self initializeConnectors: cout class: MolViewConnectorOut parameters: outParameters events: outEvents services: outServices.
]

{ #category : #initialization }
MolViewComponent >> initializeConnectors: aCollection class: aClass parameters: parameters events: events services: services [
	"add the view connectors in to the view component"
	parameters collect: [ :parameter | aClass new space: self space; fromParameter: parameter ] into: aCollection.
	events collect: [ :event | aClass new space: self space; fromEvent: event ] into: aCollection.
	services collect: [ :service | aClass new space: self space; fromService: service ] into: aCollection.
]

{ #category : #initialization }
MolViewComponent >> initializeInteractions [
	| interaction |
	interaction := RSHighlightable new.
	interaction highlightBorder: (RSBorder new width: 5; color: self highlightColor).
	rsobject @ interaction.

]

{ #category : #initialization }
MolViewComponent >> initializeSpace: aSpace [ 
	space := aSpace.
]

{ #category : #initialization }
MolViewComponent >> initializeVariables [
	cin := LinkedList new.
	cout := LinkedList new.

]

{ #category : #testing }
MolViewComponent >> isViewComponent [
	^true.
]

{ #category : #coloring }
MolViewComponent >> resetPortsColor [
	self changePortsColor: Color transparent.
]

{ #category : #accessing }
MolViewComponent >> space: aSpace [
	space := aSpace.
	cin do: [ :element | element space: aSpace ].
	cout do: [ :element | element space: aSpace ].
]

{ #category : #visitor }
MolViewComponent >> visitedBy: aVisitor [ 
	aVisitor visit: self.
	cin do: [ :connector | connector visitedBy: aVisitor ].
	cout do: [ :connector | connector visitedBy: aVisitor ].
]
