"
Contains the colors for the different aspect of the ui.
"
Class {
	#name : #MolViewUITheme,
	#superclass : #Object,
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'as yet unclassified' }
MolViewUITheme >> componentBackground [
	^ (Color fromHexString: 'EBE9E9') translucent.
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> componentHighLight [
	^ Color blue translucent.
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> connectorEvent [
	^ Color fromHexString: '61A2D1'.
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> connectorParameter [
	^ Color fromHexString: '8AC926'.
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> connectorService [
	^ Color fromHexString: 'FCB07E'.
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> portOnDragGhost [
	^Color blue lighter translucent
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> portOnDragLine [
	^Color gray translucent
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> portOnHoverComplements [
	^Color green translucent
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> portOnHoverSelf [
	^Color blue translucent
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> relation [
	^Color darkGray
]

{ #category : #'as yet unclassified' }
MolViewUITheme >> relationHighlight [
	^Color red lighter.
]
