"
A out connector class
"
Class {
	#name : #MolViewConnectorOut,
	#superclass : #MolViewConnector,
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'as yet unclassified' }
MolViewConnectorOut >> drawConnectorOut [
	"create and add the little shape in front of the connector"
	| positionOrigin |
	positionOrigin := (0.5 * (self rsobject width))@0.
	port := MolViewConnectorPort new initializeFrom: self.
	port createOutPort; position: positionOrigin + (20@0).
	self rsobject add: (port portShape).
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

{ #category : #'as yet unclassified' }
MolViewConnectorOut >> triggerHighlightPortPolicy [
	self space triggerHighlightOutPortPolicy: self.
]
