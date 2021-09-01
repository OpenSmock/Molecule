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
	showComponent component: self target.
	showComponent componentShape: RSComposite new.
	showComponent popup: self target.
	showComponent componentShape @ showComponent popup.
	showComponent legend: aCanvas.
	aCanvas add: showComponent componentShape.
	aCanvas @ RSCanvasController.
	
	"add zoom in tab"
	zoom := RSZoomToFitCanvasInteraction new.
	zoom onShape: aCanvas.
	zoom := RSZoomableCanvasInteraction new.
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
