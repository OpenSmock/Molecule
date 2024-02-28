Class {
	#name : #MolInterfacesTest,
	#superclass : #TestCase,
	#instVars : [
		'localTimeEvents'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolInterfacesTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	localTimeEvents := MolInterfaces new.
	localTimeEvents interface: MolMyLocalTimeEvents.
]

{ #category : #running }
MolInterfacesTest >> testBrowseButtonActivated [

	| enabled |
	localTimeEvents requiredList selectItem: MolMyAlarmComponent.
	enabled := localTimeEvents buttonBrowse isEnabled.
	self assert: [ enabled ]
]

{ #category : #running }
MolInterfacesTest >> testRequiredAnd [

	localTimeEvents dropList selectItem: 'Required AND Offered'.
	self assert: [ localTimeEvents requiredList items size = 0 ]
]

{ #category : #running }
MolInterfacesTest >> testRequiredOr [
	"no need to select an option since OR is selected by default"

	self assert: [ localTimeEvents requiredList items size = 2 ]
]

{ #category : #running }
MolInterfacesTest >> testRequiredXor [

	localTimeEvents dropList selectItem: 'Required XOR Offered'.
	self assert: [ localTimeEvents requiredList items size = 2 ]
]

{ #category : #running }
MolInterfacesTest >> testTitle [

	self assert: [ localTimeEvents title = 'MolMyLocalTimeEvents events' ]
]
