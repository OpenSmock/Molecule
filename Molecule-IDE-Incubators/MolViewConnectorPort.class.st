Class {
	#name : #MolViewConnectorPort,
	#superclass : #Object,
	#instVars : [
		'portShape',
		'connector'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'as yet unclassified' }
MolViewConnectorPort >> createInPort [
	| halfCircle |
	halfCircle := (RSPieSlice new
		externalRadius: 16;
		innerRadius: 12;
		alphaAngle: -90;
		betaAngle: 90;
		color: Color black;
		yourself).
	portShape add: halfCircle.
]

{ #category : #'as yet unclassified' }
MolViewConnectorPort >> createOutPort [
	| circle |
	circle := (RSEllipse new
		extent: (22@22);
		color: Color black;
		yourself).
	portShape add: circle.
]

{ #category : #'as yet unclassified' }
MolViewConnectorPort >> doHoverPolicy [
	portShape paint: Color blue translucent.
	connector triggerHighlightPortPolicy.
]

{ #category : #'as yet unclassified' }
MolViewConnectorPort >> doUnhoverPolicy [
	portShape paint: Color blue translucent.
	connector triggerUnhighlightPortPolicy.
]

{ #category : #initialization }
MolViewConnectorPort >> initialize [
	portShape := RSComposite new.
	portShape extent: (32@32).
	portShape
		when: RSMouseEnter do: [ :evt | self doHoverPolicy. evt signalUpdate ];
		when: RSMouseLeave do: [ :evt | self doUnhoverPolicy. evt signalUpdate ].
	
]

{ #category : #initialization }
MolViewConnectorPort >> initializeFrom: aConnector [
	connector := aConnector.
]

{ #category : #accessing }
MolViewConnectorPort >> portShape [
	^portShape.
]

{ #category : #accessing }
MolViewConnectorPort >> position: aPoint [ 
	portShape position: aPoint.
]
