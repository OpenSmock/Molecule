"
A in connector class.
"
Class {
	#name : #MolViewConnectorIn,
	#superclass : #MolViewConnector,
	#category : #'Molecule-IDE-Incubator-Mol View'
}

{ #category : #testing }
MolViewConnectorIn >> canConnectWith: aConnector [
	aConnector ifNil: [ ^false ].
	(aConnector isConnector)  ifFalse: [ ^false ].
	(aConnector isConnectorOut) ifFalse: [ ^false ].
	(aConnector isAlreadyInRelation: self) ifTrue: [ ^false ].
	^(self isSameTraitAs: aConnector).
]

{ #category : #drawing }
MolViewConnectorIn >> drawConnectorIn [
	"create and add the little shape in front of the connector"
	| positionOrigin |
	positionOrigin := (-0.5 * (self rsobject width))@0.
	port := (MolViewPort new: self space) initializeFrom: self.
	port drawInPort; position: positionOrigin + (-20@0).
	self rsobject add: (port rsobject).
]

{ #category : #'instance creation' }
MolViewConnectorIn >> fromEvent: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self eventColor.
	self drawConnectorIn.
]

{ #category : #'instance creation' }
MolViewConnectorIn >> fromParameter: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self parameterColor.
	self drawConnectorIn.
]

{ #category : #'instance creation' }
MolViewConnectorIn >> fromService: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self serviceColor.
	self drawConnectorIn.
]

{ #category : #testing }
MolViewConnectorIn >> isConnectorIn [
	^true
]

{ #category : #testing }
MolViewConnectorIn >> isConnectorOut [
	^false
]

{ #category : #interactions }
MolViewConnectorIn >> triggerHighlightPortPolicy [
	self space triggerHighlightInPortPolicy: self.
]
