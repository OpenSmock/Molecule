Class {
	#name : #MolPopupTest,
	#superclass : #TestCase,
	#instVars : [
		'popup'
	],
	#category : #'Molecule-IDE-Incubator-Tests-Cases'
}

{ #category : #running }
MolPopupTest >> setUp [
	super setUp.
	popup := MolPopup new.
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
MolPopupTest >> testPopupTitle [
	
	self assert: (popup popup: RSPopup new title: MolGPSDataImpl) equals: popup
]

{ #category : #tests }
MolPopupTest >> testPopupTitleItems [
	self assert: (popup popup: RSPopup new title: MolGPSDataImpl items: {RSLabel new. RSEllipse new}) equals: popup
]
