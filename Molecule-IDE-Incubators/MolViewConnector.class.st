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
		'port'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'as yet unclassified' }
MolViewConnector >> changePortColor: aColor [ 
	port portShape paint: aColor.
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
	^ Color purple translucent.
]

{ #category : #defaults }
MolViewConnector >> highlightColor [
	^Color green translucent.
]

{ #category : #'as yet unclassified' }
MolViewConnector >> highlightPort [
	self changePortColor: self highlightColor.
]

{ #category : #testing }
MolViewConnector >> isSameTraitAs: aConnector [
	^(self trait) = (aConnector trait). 
]

{ #category : #colors }
MolViewConnector >> parameterColor [
	^ Color red translucent.
]

{ #category : #colors }
MolViewConnector >> serviceColor [
	^ Color green translucent.
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

{ #category : #'as yet unclassified' }
MolViewConnector >> triggerUnhighlightPortPolicy [
	self space triggerUnhighlightPortPolicy.
]
