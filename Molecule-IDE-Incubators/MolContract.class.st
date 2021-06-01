"
class for the component contract
"
Class {
	#name : #MolContract,
	#superclass : #Object,
	#category : #'Molecule-IDE-Incubators-Contract'
}

{ #category : #'as yet unclassified' }
MolContract >> consumedEvents: aComponent [
		(self hasContract: aComponent )
		ifTrue: [ 
			aComponent consumedComponentEvents isEmpty 
			ifFalse: [^aComponent consumedComponentEvents]
			ifTrue: [^'--'].
			]
		ifFalse: [^'--' ]
]

{ #category : #testing }
MolContract >> hasContract: aComponent [
	aComponent haveComponentType
			ifTrue: [ ^true ]
			ifFalse: [ ^false ]
]

{ #category : #'as yet unclassified' }
MolContract >> producedEvents: aComponent [
	(self hasContract: aComponent )
		ifTrue: [ 
			aComponent producedComponentEvents isEmpty 
			ifFalse: [^aComponent producedComponentEvents]
			ifTrue: [^'--'].
			]
		ifFalse: [ ^'--']
]

{ #category : #'as yet unclassified' }
MolContract >> providedParameters: aComponent [
	(self hasContract: aComponent )
		ifTrue: [ 
			aComponent providedComponentParameters isEmpty 
			ifFalse: [^aComponent providedComponentParameters]
			ifTrue: [^'--'].
			]
		ifFalse: [ ^'--'  ]
]

{ #category : #'as yet unclassified' }
MolContract >> providedServices: aComponent [
		(self hasContract: aComponent )
		ifTrue: [ 
			aComponent providedComponentServices isEmpty 
			ifFalse: [^aComponent providedComponentServices]
			ifTrue: [^'--'].
			]
		ifFalse: [^'--' ]
]

{ #category : #'accessing structure variables' }
MolContract >> type: aComponent [
	"^component allTraits detect: [ :aClass | aClass usesTrait: MolComponentType ] ifNone: nil."
	aComponent componentType isNotNil ifTrue: [ ^aComponent componentType  ]
	ifFalse: [ ^'--' ]
]

{ #category : #'as yet unclassified' }
MolContract >> usedParameters: aComponent [
	(self hasContract: aComponent )
		ifTrue: [ 
			aComponent usedComponentParameters isEmpty 
			ifFalse: [^aComponent usedComponentParameters]
			ifTrue: [^'--'].
			]
		ifFalse: [ ^'--' ]
]

{ #category : #accessing }
MolContract >> usedServices: aComponent [
	 (self hasContract: aComponent )
		ifTrue: [ 
			aComponent usedComponentServices isEmpty 
			ifFalse: [^aComponent usedComponentServices]
			ifTrue: [^'--'].
			]
		ifFalse: [ ^'--' ]
]
