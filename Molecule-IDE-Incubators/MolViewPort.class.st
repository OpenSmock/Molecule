"
The port of a MolViewConnector.

Can be hovered : highlight it and the corresponding port on the space.
Can be drag : try to connect it on the dragged port and create a relation.
"
Class {
	#name : #MolViewPort,
	#superclass : #MolViewElement,
	#instVars : [
		'portShape',
		'connector'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #accessing }
MolViewPort >> connector [
	^connector.
]

{ #category : #drawing }
MolViewPort >> drawInPort [
	| halfCircle |
	halfCircle := (RSPieSlice new
		externalRadius: 16;
		innerRadius: 12;
		alphaAngle: -90;
		betaAngle: 90;
		color: Color black;
		yourself).
	rsobject add: halfCircle.
]

{ #category : #drawing }
MolViewPort >> drawOutPort [
	| circle |
	circle := (RSEllipse new
		extent: (22@22);
		color: Color black;
		yourself).
	rsobject add: circle.
]

{ #category : #initialization }
MolViewPort >> initialize [
	rsobject := RSComposite new.
	rsobject extent: (32@32).
	rsobject @ (MolViewPortHover new applyOn: self).
	rsobject @ (MolViewPortDrag new applyOn: self).
	
]

{ #category : #initialization }
MolViewPort >> initializeFrom: aConnector [
	connector := aConnector.
]

{ #category : #testing }
MolViewPort >> isPort [
	^true
]

{ #category : #accessing }
MolViewPort >> position: aPoint [ 
	rsobject position: aPoint.
]

{ #category : #testing }
MolViewPort >> tryConnectWith: anElement [
	anElement ifNil: [ ^self ].
	(anElement isConnector) ifTrue: [ connector tryConnectWith: anElement ].
	(anElement isPort) ifTrue: [ connector tryConnectWith: (anElement connector) ].
]
