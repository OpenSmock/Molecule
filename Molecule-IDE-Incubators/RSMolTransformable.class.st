"
class to edit component for the creation
"
Class {
	#name : #RSMolTransformable,
	#superclass : #RSTransformable,
	#category : #'Molecule-IDE-Incubators'
}

{ #category : #'accessing - shapes' }
RSMolTransformable >> createHandleFor: association [
	| handle |
	handle := RSEllipse new
		size: 5;
		model: association;
		color: Color white;
		border: (RSBorder new width: 1; color: Color gray);
		draggable;
		yourself.
	handle announcer
		when: RSMouseEnter send: #showCursor: to: self;
		when: RSMouseLeave send: #removeCursor to: self;
		when: RSMouseDragStart send: #saveCurrentShapeState to: self;
		when: RSPositionChangedEvent send: #updateCurrentShape: to: self.
	^ handle
]
