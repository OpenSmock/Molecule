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
		ifTrue: [ ^aComponent consumedComponentEvents.]
		ifFalse: [ ^nil ]
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
		ifTrue: [ ^aComponent producedComponentEvents   .]
		ifFalse: [ ^nil ]
]

{ #category : #'as yet unclassified' }
MolContract >> providedParameters: aComponent [
	(self hasContract: aComponent )
		ifTrue: [ ^aComponent providedComponentParameters  .]
		ifFalse: [ ^nil ]
]

{ #category : #'as yet unclassified' }
MolContract >> providedServices: aComponent [
		(self hasContract: aComponent )
		ifTrue: [ ^aComponent providedComponentServices .]
		ifFalse: [ ^nil ]
]

{ #category : #'accessing structure variables' }
MolContract >> type: aComponent [
	"^component allTraits detect: [ :aClass | aClass usesTrait: MolComponentType ] ifNone: nil."
	^aComponent componentType
]

{ #category : #'as yet unclassified' }
MolContract >> usedParameters: aComponent [
	(self hasContract: aComponent )
		ifTrue: [ ^aComponent usedComponentParameters.]
		ifFalse: [ ^nil ]
]

{ #category : #accessing }
MolContract >> usedServices: aComponent [
	 (self hasContract: aComponent )
		ifTrue: [ ^aComponent usedComponentServices.]
		ifFalse: [ ^nil ]
]
