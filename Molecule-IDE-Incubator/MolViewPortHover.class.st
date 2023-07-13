"
Interration for a MolViewPort on hover.

1) change self color
2) change corresponding port color by triggering a signal to:
	-> associed connector
	-> the space of the connector
	-> the components of the space
	-> the connectors of each components
	-> the port of each connector if it corespond
"
Class {
	#name : #MolViewPortHover,
	#superclass : #MolViewPortInteraction,
	#category : #'Molecule-IDE-Incubator-Mol View'
}

{ #category : #action }
MolViewPortHover >> doHoverPolicy [
	port rsobject paint: self hoverColor.
	port connector triggerHighlightPortPolicy.
]

{ #category : #action }
MolViewPortHover >> doUnhoverPolicy [
	port connector triggerUnhighlightPortPolicy.
]

{ #category : #colors }
MolViewPortHover >> hoverColor [
	^theme portOnHoverSelf.
]

{ #category : #hooks }
MolViewPortHover >> onShape: aShape [
	aShape
		when: RSMouseEnter do: [ :evt | self doHoverPolicy. evt signalUpdate ];
		when: RSMouseLeave do: [ :evt | self doUnhoverPolicy. evt signalUpdate ].
]
