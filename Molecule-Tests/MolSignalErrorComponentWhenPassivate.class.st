Class {
	#name : #MolSignalErrorComponentWhenPassivate,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolBasicComponent',
	#classTraits : 'MolBasicComponent classTrait',
	#instVars : [
		'isRaisedErrorOnPassivate'
	],
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #'life cycle' }
MolSignalErrorComponentWhenPassivate >> componentPassivate [
	"here write the code corresponding to component passivation phase"
	
	"Simulate an error when passivate - for testing"
	self isRaisedErrorOnPassivate ifTrue:[ Error new signal ].
]

{ #category : #accessing }
MolSignalErrorComponentWhenPassivate >> isRaisedErrorOnPassivate [

	^ isRaisedErrorOnPassivate ifNil: [ true ]
]

{ #category : #accessing }
MolSignalErrorComponentWhenPassivate >> isRaisedErrorOnPassivate: anObject [

	isRaisedErrorOnPassivate := anObject
]
