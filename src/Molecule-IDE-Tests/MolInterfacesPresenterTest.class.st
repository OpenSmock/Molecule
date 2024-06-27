Class {
	#name : #MolInterfacesPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'localTimeEvents'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolInterfacesPresenterTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	localTimeEvents := MolInterfacesPresenter new.
	localTimeEvents interface: MolMyLocalTimeEvents.
]

{ #category : #running }
MolInterfacesPresenterTest >> testBrowseButtonActivated [

	| enabled |
	localTimeEvents requiredList selectItem: MolMyAlarmComponent.
	enabled := localTimeEvents buttonBrowse isEnabled.
	self assert: [ enabled ]
]

{ #category : #running }
MolInterfacesPresenterTest >> testRequiredAnd [

	localTimeEvents dropList selectItem: 'Required AND Offered'.
	self assert: [ localTimeEvents requiredList items size = 0 ]
]

{ #category : #running }
MolInterfacesPresenterTest >> testRequiredOr [
	"no need to select an option since OR is selected by default"

	self assert: [ localTimeEvents requiredList items size = 2 ]
]

{ #category : #running }
MolInterfacesPresenterTest >> testRequiredXor [

	localTimeEvents dropList selectItem: 'Required XOR Offered'.
	self assert: [ localTimeEvents requiredList items size = 2 ]
]

{ #category : #running }
MolInterfacesPresenterTest >> testTitle [

	self assert: [ localTimeEvents title = 'MolMyLocalTimeEvents events' ]
]
