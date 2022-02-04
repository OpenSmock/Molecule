"
This class contain the connector view.
- a connector is compose of a trait and a pin
- a connector can be in relation with another connector to link two components together.
"
Class {
	#name : #MolViewConnector,
	#superclass : #MolViewElement,
	#instVars : [
		'trait',
		'port',
		'relations'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #adding }
MolViewConnector >> addRelation: aRelation [ 
	relations add: aRelation.
]

{ #category : #testing }
MolViewConnector >> canConnectWith: aConnector [
	self subclassResponsibility
]

{ #category : #coloring }
MolViewConnector >> changePortColor: aColor [ 
	port rsobject paint: aColor.
]

{ #category : #drawing }
MolViewConnector >> drawLabelWithColor: aColor [
	| label body bodySize |
	rsobject := RSComposite new.
	label := RSLabel new
			color: (Color black);
			fontName: 'Source Sans Pro';
			fontSize: 20;
			text: self traitName;
			yourself.
	bodySize := (label width + 15)@(label height).
	body := RSBox new
		color: aColor;
		cornerRadius: 5;
		extent: bodySize;
		border: (RSBorder new
				width: 1;
				color: (Color black));
		yourself.
	rsobject add: body; add: label.
	rsobject adjustToChildren.
]

{ #category : #colors }
MolViewConnector >> eventColor [
	^self theme connectorEvent.
]

{ #category : #colors }
MolViewConnector >> highlightColor [
	^self theme portOnHoverComplements.
]

{ #category : #interactions }
MolViewConnector >> highlightPort [
	self changePortColor: self highlightColor.
]

{ #category : #'instance creation' }
MolViewConnector >> initialize [ 
	relations := Set new.
]

{ #category : #testing }
MolViewConnector >> isAlreadyInRelation: aConnector [
	^(relations select: [ :relation | relation existFor: self and: aConnector ]) isNotEmpty.
]

{ #category : #testing }
MolViewConnector >> isConnector [
	^true
]

{ #category : #testing }
MolViewConnector >> isConnectorIn [ 
	self subclassResponsibility
]

{ #category : #testing }
MolViewConnector >> isConnectorOut [
	self subclassResponsibility
]

{ #category : #testing }
MolViewConnector >> isSameTraitAs: aConnector [
	^(self trait) = (aConnector trait). 
]

{ #category : #links }
MolViewConnector >> makeRelationWith: aConnector [
	| relation |
	relation := (MolViewRelation new with: self and: aConnector).
	self addRelation: relation.
	aConnector addRelation: relation.
]

{ #category : #colors }
MolViewConnector >> parameterColor [
	^self theme connectorParameter.
]

{ #category : #accessing }
MolViewConnector >> port [
	^ port
]

{ #category : #removing }
MolViewConnector >> removeRelation: aRelation [
	relations remove: aRelation.
]

{ #category : #colors }
MolViewConnector >> serviceColor [
	^self theme connectorService.
]

{ #category : #accessing }
MolViewConnector >> trait [
	^ trait
]

{ #category : #'instance creation' }
MolViewConnector >> trait: aTrait [ 
	trait := aTrait.
]

{ #category : #accessing }
MolViewConnector >> traitName [
	^trait name.
]

{ #category : #interactions }
MolViewConnector >> triggerUnhighlightPortPolicy [
	self space triggerUnhighlightPortPolicy.
]

{ #category : #testing }
MolViewConnector >> tryConnectWith: aConnector [ 
	(self canConnectWith: aConnector) ifTrue: [ self makeRelationWith: aConnector ].
]

{ #category : #visitor }
MolViewConnector >> visitedBy: aVisitor [ 
	aVisitor visit: self.
	aVisitor visit: port.
]
