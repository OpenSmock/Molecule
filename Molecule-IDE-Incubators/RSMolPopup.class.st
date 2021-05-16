"
Class for edit a popup on component 
"
Class {
	#name : #RSMolPopup,
	#superclass : #RSPopup,
	#category : #'Molecule-IDE-Incubators-Popup'
}

{ #category : #initialization }
RSMolPopup >> initialize [ 
	super initialize.
]

{ #category : #accessing }
RSMolPopup >> textColor: aColor [ 
	shapeBuilder labelBuilder labelShape color: aColor.
	
]

{ #category : #accessing }
RSMolPopup >> textColor: aColor fontSize: aFont [
	shapeBuilder labelBuilder labelShape color: aColor; fontSize: aFont.
	
]
