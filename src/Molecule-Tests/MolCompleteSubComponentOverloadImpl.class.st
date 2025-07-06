Class {
	#name : #MolCompleteSubComponentOverloadImpl,
	#superclass : #MolCompleteComponentOverloadImpl,
	#instVars : [
		'dontRemoveMe'
	],
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #accessing }
MolCompleteSubComponentOverloadImpl >> dontRemoveMe [

	^ dontRemoveMe 
]

{ #category : #accessing }
MolCompleteSubComponentOverloadImpl >> dontRemoveMe: anObject [

	dontRemoveMe := anObject 
]
