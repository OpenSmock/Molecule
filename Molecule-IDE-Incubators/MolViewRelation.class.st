"
A relation between two connectors.

display a link.

Can be left-click: destroy this relation.
"
Class {
	#name : #MolViewRelation,
	#superclass : #MolViewElement,
	#instVars : [
		'connectorIn',
		'connectorOut'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #drawing }
MolViewRelation >> drawRelation [
	rsobject := (RSLine new
		width: 10;
		color: Color darkGray;
		from: connectorIn port rsobject;
		to: connectorOut port rsobject;
		perform: 'capRound' asSymbol;
		yourself).
	self space addConnectorsRelation: self.
]

{ #category : #equality }
MolViewRelation >> existFor: aConnector1 and: aConnector2 [ 
	(aConnector1 isConnectorIn)
	ifTrue: [ ^(aConnector1 = connectorIn) and: (aConnector2 = connectorOut) ]
	ifFalse:  [ ^(aConnector2 = connectorIn) and: (aConnector1 = connectorOut) ].
]

{ #category : #removing }
MolViewRelation >> removeRelation [
	connectorIn removeRelation: self.
	connectorOut removeRelation: self.
	space removeRelation: self.
]

{ #category : #initialization }
MolViewRelation >> with: aConnector1 and: aConnector2 [
	| interaction |
	(aConnector1 isConnectorIn)
	ifTrue: [ connectorIn := aConnector1. connectorOut := aConnector2 ]
	ifFalse: [ connectorIn := aConnector2. connectorOut := aConnector1 ].
	self space: (aConnector1 space).
	self drawRelation.

	interaction := RSHighlightable new.
	interaction highlightColor: Color red lighter.
	rsobject @ interaction.
	rsobject when: RSMouseLeftClick do: [ self removeRelation ].
]
