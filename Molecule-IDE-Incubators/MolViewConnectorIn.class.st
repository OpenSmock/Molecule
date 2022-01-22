"
A in connector class.
"
Class {
	#name : #MolViewConnectorIn,
	#superclass : #MolViewConnector,
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'as yet unclassified' }
MolViewConnectorIn >> drawConnectorIn [
	"create and add the little shape in front of the connector"
	| positionOrigin |
	positionOrigin := (-0.5 * (self rsobject width))@0.
	port := MolViewConnectorPort new initializeFrom: self.
	port createInPort; position: positionOrigin + (-20@0).
	self rsobject add: (port portShape).
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

{ #category : #'as yet unclassified' }
MolViewConnectorIn >> triggerHighlightPortPolicy [
	self space triggerHighlightInPortPolicy: self.
]
