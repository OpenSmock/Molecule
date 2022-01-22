Class {
	#name : #MolViewConnector,
	#superclass : #MolViewElement,
	#instVars : [
		'trait'
	],
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'as yet unclassified' }
MolViewConnector >> drawLabel [
	| label body bodySize |
	rsobject := RSComposite new.
	label := RSLabel new
			color: (Color black);
			fontName: 'Source Sans Pro';
			fontSize: 20;
			text: self labelString;
			yourself.
	bodySize := (label width + 15)@(label height).
	body := RSBox new
		color: Color yellow translucent;
		cornerRadius: 5;
		extent: bodySize;
		border: (RSBorder new
				width: 1;
				color: (Color black));
		yourself.
	rsobject add: body; add: label.
	rsobject adjustToChildren.
]

{ #category : #'as yet unclassified' }
MolViewConnector >> drawLabelWithColor: aColor [
	| label body bodySize |
	rsobject := RSComposite new.
	label := RSLabel new
			color: (Color black);
			fontName: 'Source Sans Pro';
			fontSize: 20;
			text: self labelString;
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

{ #category : #'as yet unclassified' }
MolViewConnector >> eventColor [
	^ Color purple translucent.
]

{ #category : #accessing }
MolViewConnector >> labelString [
	^trait name.
]

{ #category : #'as yet unclassified' }
MolViewConnector >> parameterColor [
	^ Color red translucent.
]

{ #category : #'as yet unclassified' }
MolViewConnector >> serviceColor [
	^ Color green translucent.
]

{ #category : #'instance creation' }
MolViewConnector >> trait: aTrait [ 
	trait := aTrait.
]
