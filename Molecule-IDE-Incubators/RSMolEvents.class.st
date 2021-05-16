"
Class for the event when you click on a component (in search window)
"
Class {
	#name : #RSMolEvents,
	#superclass : #RSInteraction,
	#instVars : [
		'selectedShape'
	],
	#category : #'Molecule-IDE-Incubators-Events'
}

{ #category : #hooks }
RSMolEvents >> initialize [
	super initialize.
]

{ #category : #hooks }
RSMolEvents >> onShape: aShape [
	aShape 
		when: RSMouseDoubleLeftClick
		do: [ :evt | | usedComponentServices usedComponentParameters consumedComponentEvents providedComponentServices
			providedComponentParameters producedComponentEvents showComponent | 
			
			showComponent := SpMolShowComponent new. 
			
			(aShape model == MolAbstractComponentImpl) | (aShape model ==MolTestComponentImplA) | 
			(aShape model == MolTestComponentImplB) | (aShape model == MolTestComponentImplC)
				ifFalse:[
			usedComponentServices := OrderedCollection new.
			aShape model usedComponentServices do: [:compo| compo users do: [:comp | comp == comp ifTrue:[ usedComponentServices add: comp ]]].
			usedComponentParameters := OrderedCollection new.
			aShape model usedComponentParameters do: [:compo| compo users do: [:comp | usedComponentParameters add: comp]].
			consumedComponentEvents := OrderedCollection new.
			aShape model consumedComponentEvents do: [:compo| compo users do: [:comp | consumedComponentEvents add: comp]].
			providedComponentServices := OrderedCollection new.
			aShape model providedComponentServices do: [:compo| compo users do: [:comp | providedComponentServices add: comp]].
			providedComponentParameters := OrderedCollection new.
			aShape model providedComponentParameters do: [:compo| compo users do: [:comp | providedComponentParameters add: comp]].
			producedComponentEvents := OrderedCollection new.
			aShape model producedComponentEvents do: [:compo| compo users do: [:comp | producedComponentEvents add: comp]].
			
			showComponent usedComponentServicesConnected: usedComponentServices.
			showComponent usedComponentParametersConnected: usedComponentParameters.
			showComponent providedComponentServicesConnected: providedComponentServices.
			showComponent providedComponentParametersConnected: providedComponentParameters.
			showComponent producedComponentEventsConnected: producedComponentEvents.
			showComponent consumedComponentEventsConnected: consumedComponentEvents.
			].
			showComponent component: aShape model.
			showComponent openWithSpec
			
			].
		
	"aShape 
		when: RSMouseLeftClick  
		do: [ :evt | 
			| zoom | 
			zoom := RSMolZoomCanvas new. 
			zoom scale: aShape.
			zoom scale > 3
				ifTrue:  [ zoom zoomOut: aShape ]
				ifFalse: [ zoom zoomIn: aShape ].
			 ]."
	
	aShape 
		when: RSMouseRightClick
		do: [ :evt | | molMenu |
				self selectedShape: aShape model. 
				molMenu := MolMenu new.
				molMenu selectedComponent: selectedShape.
				molMenu open: molMenu. ].
		
	
]

{ #category : #'as yet unclassified' }
RSMolEvents >> selectedShape [
	^selectedShape 
]

{ #category : #accessing }
RSMolEvents >> selectedShape: aShape [
	selectedShape := aShape
]
