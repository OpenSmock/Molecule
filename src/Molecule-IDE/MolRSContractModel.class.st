"
I am used as a model for the Roassal3 inspection add-on (see: `MolComponentToRoassal`).

I sort the different contracts (services, events, parameters).
I contain:
- the `#component`: the `MolComponentImpl` of the modelized component.
- the `#eventClass`: the class of the modelized event.
- the `#name`: the name of the component if the model is source, or the name of the targeted component if the model is target.
- the `#color`: the `Color` of the event on the Roassal canvas (the colors are defined in `MolComponentToRoassal`).
- the `#rsCornerRadius`: the `RSCornerRadius` object to shape the Roassal element (right for source, left for target).
"
Class {
	#name : #MolRSContractModel,
	#superclass : #Object,
	#instVars : [
		'component',
		'name',
		'eventClass'
	],
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #testing }
MolRSContractModel class >> isAbstract [

	^ self == MolRSContractModel
]

{ #category : #comparing }
MolRSContractModel >> <= aMolRSContractModel [

	^ self eventClass name < aMolRSContractModel eventClass name
]

{ #category : #debug }
MolRSContractModel >> breakOnceOnSelector: aSelector [ 

	(self component breakOnceOnCallTo: aSelector)

]

{ #category : #debug }
MolRSContractModel >> canBreakOn: aString [

	^ self explicitRequirement
]

{ #category : #accessing }
MolRSContractModel >> component [

	^ component
]

{ #category : #accessing }
MolRSContractModel >> component: anObject [

	component := anObject
]

{ #category : #accessing }
MolRSContractModel >> eventClass [

	^ eventClass
]

{ #category : #accessing }
MolRSContractModel >> eventClass: anObject [

	eventClass := anObject
]

{ #category : #testing }
MolRSContractModel >> isContractSource [

	^ self explicitRequirement
]

{ #category : #accessing }
MolRSContractModel >> name [

	^ name
]

{ #category : #accessing }
MolRSContractModel >> name: anObject [

	name := anObject
]
