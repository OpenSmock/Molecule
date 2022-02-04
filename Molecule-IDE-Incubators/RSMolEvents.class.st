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
RSMolEvents >> onShape: aShape [

	aShape when: RSMouseDoubleLeftClick do: [ :evt | 
		| usedComponentServices usedComponentParameters consumedComponentEvents providedComponentServices providedComponentParameters producedComponentEvents showComponent |
		showComponent := SpMolShowComponent new.
		aShape model haveComponentType ifTrue: [ 
			usedComponentServices := OrderedCollection new.
			aShape model usedComponentServices do: [ :compo | 
				compo users do: [ :comp | 
					comp == aShape model ifFalse: [ usedComponentServices add: comp ] ] ].

			usedComponentParameters := OrderedCollection new.
			aShape model usedComponentParameters do: [ :compo | 
				compo users do: [ :comp | 
					comp == aShape model ifFalse: [ 
						usedComponentParameters add: comp ] ] ].

			consumedComponentEvents := OrderedCollection new.
			aShape model consumedComponentEvents do: [ :compo | 
				compo users do: [ :comp | 
					comp == aShape model ifFalse: [ 
						consumedComponentEvents add: comp ] ] ].

			providedComponentServices := OrderedCollection new.
			aShape model providedComponentServices do: [ :compo | 
				compo users do: [ :comp | 
					comp == aShape model ifFalse: [ 
						providedComponentServices add: comp ] ] ].

			providedComponentParameters := OrderedCollection new.
			aShape model providedComponentParameters do: [ :compo | 
				compo users do: [ :comp | 
					comp == aShape model ifFalse: [ 
						providedComponentParameters add: comp ] ] ].

			producedComponentEvents := OrderedCollection new.
			aShape model producedComponentEvents do: [ :compo | 
				compo users do: [ :comp | 
					comp == aShape model ifFalse: [ 
						producedComponentEvents add: comp ] ] ].

			showComponent usedComponentServicesConnected: usedComponentServices.
			showComponent usedComponentParametersConnected:
				usedComponentParameters.
			showComponent providedComponentServicesConnected:
				providedComponentServices.
			showComponent providedComponentParametersConnected:
				providedComponentParameters.
			showComponent producedComponentEventsConnected:
				producedComponentEvents.
			showComponent consumedComponentEventsConnected:
				consumedComponentEvents ].
		showComponent component: aShape model.
		showComponent open ].

	aShape when: RSMouseRightClick do: [ :evt | 
		| molMenu |
		self selectedShape: aShape model.
		molMenu := MolMenu new.
		molMenu selectedComponent: selectedShape.
		molMenu open: molMenu ]
]

{ #category : #accessing }
RSMolEvents >> selectedShape [
	^selectedShape 
]

{ #category : #accessing }
RSMolEvents >> selectedShape: aShape [
	selectedShape := aShape
]
