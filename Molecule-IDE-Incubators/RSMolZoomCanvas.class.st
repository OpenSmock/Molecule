"
Class for Interaction : zoom in canvas
"
Class {
	#name : #RSMolZoomCanvas,
	#superclass : #RSKeyNavigationCanvas,
	#instVars : [
		'scale',
		'newScale'
	],
	#category : #'Molecule-IDE-Incubators-Interaction'
}

{ #category : #utilities }
RSMolZoomCanvas >> correctCameraPosition: aCanvas [ 
	^ self 
		correctCameraPosition: aCanvas
		inRectangle: (self expandedRectangle: aCanvas)
		position: aCanvas camera position  
		scale: aCanvas camera scale
]

{ #category : #utilities }
RSMolZoomCanvas >> correctCameraPosition: aCanvas scale: aScale [
	^ self 
		correctCameraPosition: aCanvas
		inRectangle: (self expandedRectangle: aCanvas)
		position: aCanvas camera position
		scale: aScale
]

{ #category : #utilities }
RSMolZoomCanvas >> encompassingRectangleFor: aCanvas [
	^ aCanvas propertyAt: #encompassingRectangle 
		ifAbsentPut: [ aCanvas encompassingRectangle  ].
]

{ #category : #utilities }
RSMolZoomCanvas >> expandedRectangle: aCanvas [
	| key | 
	key := #expanedEncompassingRectangle.
	^ aCanvas propertyAt: key ifAbsentPut: [ 
		| rectangle |
		rectangle := self encompassingRectangleFor: aCanvas.
		self configuration padding expandRectangle: rectangle ].
	
]

{ #category : #initialization }
RSMolZoomCanvas >> initialize [
	super initialize.
]

{ #category : #accessing }
RSMolZoomCanvas >> scale [
	^scale
]

{ #category : #'as yet unclassified' }
RSMolZoomCanvas >> scale:  aShape [
	scale := aShape parent camera scale
]

{ #category : #'events-processing' }
RSMolZoomCanvas >> zoomIn: aShape [
	self zoomMove: aShape delta: 2.5
]

{ #category : #'events-processing' }
RSMolZoomCanvas >> zoomMove: aShape delta: delta [
	|  camera correct test test2 |
	camera := aShape parent camera.
	scale := camera scale.
	test := camera canvas properties array at:2.
	test2 := test value.
	newScale := self scaleFor: delta * scale. 
	aShape newAnimation 
		easing: RSEasing backOut;
		duration: 1000 milliSeconds;
		from: scale;
		to: newScale;
		on: camera set: #scale:.
	correct := self 
		correctCameraPosition: aShape parent
		scale: newScale.
	correct = camera position ifTrue: [ ^ self ].
	aShape newAnimation 
		easing: RSEasing backOut;
		duration: 1000 milliSeconds;
		from: camera position;
		to: correct;
		on: camera set: #translateTo:.
]

{ #category : #'events-processing' }
RSMolZoomCanvas >> zoomOut: aShape [
	self zoomMove: aShape delta: 0.4.
	
]
