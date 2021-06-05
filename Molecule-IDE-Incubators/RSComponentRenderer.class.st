"
class for component renderer
"
Class {
	#name : #RSComponentRenderer,
	#superclass : #RSAbstractComponentRenderer,
	#instVars : [
		'target'
	],
	#category : #'Molecule-IDE-Incubators-Tab Renderer'
}

{ #category : #initialization }
RSComponentRenderer >> setUpCanvas: aCanvas [
	
	|  showComponent zoom |
	
	super setUpCanvas: aCanvas.
	
	showComponent := SpMolShowComponent new.
	
	"add component in tab"
	showComponent molContract: MolContract new.
	showComponent component: self target.
	showComponent componentShape: RSComposite new.
	showComponent popup: self target.
	aCanvas add: showComponent componentShape.
	
	"add zoom in tab"
	zoom := RSZoomToFitCanvas new.
	zoom onShape: aCanvas.
	zoom := RSZoomableCanvas new.
	zoom onShape: aCanvas.
	
]

{ #category : #accessing }
RSComponentRenderer >> target [
	^target
]

{ #category : #accessing }
RSComponentRenderer >> target: targetClass [
	target := targetClass 
]
