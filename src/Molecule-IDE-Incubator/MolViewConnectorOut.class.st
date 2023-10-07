"
A out connector class
"
Class {
	#name : #MolViewConnectorOut,
	#superclass : #MolViewConnector,
	#category : #'Molecule-IDE-Incubator-Mol View'
}

{ #category : #testing }
MolViewConnectorOut >> canConnectWith: aConnector [
	aConnector ifNil: [ ^false ].
	(aConnector isConnector)  ifFalse: [ ^false ].
	(aConnector isConnectorIn) ifFalse: [ ^false ].
	(aConnector isAlreadyInRelation: self) ifTrue: [ ^false ].
	^(self isSameTraitAs: aConnector).
]

{ #category : #drawing }
MolViewConnectorOut >> drawConnectorOut [
	"create and add the little shape in front of the connector"
	| positionOrigin |
	positionOrigin := (0.5 * (self rsobject width))@0.
	port := (MolViewPort new: self space) initializeFrom: self.
	port drawOutPort; position: positionOrigin + (20@0).
	self rsobject add: (port rsobject).
]

{ #category : #'instance creation' }
MolViewConnectorOut >> fromEvent: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self eventColor.
	self drawConnectorOut.
]

{ #category : #'instance creation' }
MolViewConnectorOut >> fromParameter: aTrait [
	self trait: aTrait.
	self drawLabelWithColor: self parameterColor.
	self drawConnectorOut.
]

{ #category : #'instance creation' }
MolViewConnectorOut >> fromService: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self serviceColor.
	self drawConnectorOut.
]

{ #category : #testing }
MolViewConnectorOut >> isConnectorIn [
	^false
]

{ #category : #testing }
MolViewConnectorOut >> isConnectorOut [
	^true
]

{ #category : #interactions }
MolViewConnectorOut >> triggerHighlightPortPolicy [
	self space triggerHighlightOutPortPolicy: self.
]
