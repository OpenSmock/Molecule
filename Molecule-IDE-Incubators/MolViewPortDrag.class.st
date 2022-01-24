"
Interration for a MolViewPort on drag.

1) create a ghost
2) update the ghost
3) remove the ghost and try to make a relation.
"
Class {
	#name : #MolViewPortDrag,
	#superclass : #MolViewPortInteraction,
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #colors }
MolViewPortDrag >> color [
	^Color blue translucent.
]

{ #category : #drawing }
MolViewPortDrag >> createGhost: evt [
	| shape ghost link |
	shape := evt shape.
	shape pushFront.
	ghost := shape copy
		fromRectangle: shape encompassingRectangle;
		border: (RSBorder new joinMiter; color: self color; dashArray: #(7 5));
		connectedLines: nil;
		resetChildren;
		paint: Color blue lighter translucent;
		yourself.
	shape propertyAt: #ghost put: ghost.
	shape parent add: ghost.
	
	link := (RSLine new
		width: 5;
		from: shape;
		to: ghost;
		yourself).
	shape propertyAt: #link put: link.
	shape parent add: link.

	
]

{ #category : #hooks }
MolViewPortDrag >> onShape: aShape [
	aShape
		when: RSMouseDragStart do: [ :evt | self createGhost: evt. evt signalUpdate ];
		when: RSMouseDragging do: [ :evt | self updateGhost: evt. evt signalUpdate ];
		when: RSMouseDragEnd do: [ :evt | self removeGhost: evt. evt signalUpdate ].
]

{ #category : #drawing }
MolViewPortDrag >> removeGhost: evt [
	| ghost link |
	ghost := evt shape propertyAt: #ghost.
	ghost remove.
	evt shape removeKey: #ghost.
	link := evt shape propertyAt: #link.
	link remove.
	evt shape removeKey: #link.
	
	"find a shape at this position, then verify and update it."
	self tryMakeRelation: evt.

	evt signalUpdate.
]

{ #category : #action }
MolViewPortDrag >> tryMakeRelation: evt [
	| shape |
	shape := evt canvas shapeWithActionForPositionInPixels: (evt position).
	shape = (evt canvas) ifFalse: [ port tryConnectWith: (port connector space findShape: shape) ].
]

{ #category : #drawing }
MolViewPortDrag >> updateGhost: evt [
	| d |
	d := evt camera distanceFromPixelToSpace: evt step.
	(evt shape propertyAt: #ghost) translateBy: d.
	evt signalUpdate 
]
