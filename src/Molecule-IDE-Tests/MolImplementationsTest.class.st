Class {
	#name : #MolImplementationsTest,
	#superclass : #TestCase,
	#instVars : [
		'clockImplementations',
		'geoPosImplementations'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolImplementationsTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	clockImplementations := MolImplementations new.
	clockImplementations type: MolMyClockComponent.

	geoPosImplementations := MolImplementations new.
	geoPosImplementations type: MolGeoPosEquipmentType.
]

{ #category : #running }
MolImplementationsTest >> testBrowseButtonActivated [

	| enabled |
	clockImplementations implementationList selectItem:
		MolMyClockComponentImpl.
	enabled := clockImplementations buttonBrowse isEnabled.

	self assert: [ enabled ]
]

{ #category : #running }
MolImplementationsTest >> testFilter [

	| implementations |
	geoPosImplementations implementationList filterListItems: 'gps'.
	implementations := geoPosImplementations implementationList items.

	self assert: [ implementations size = 2 ]
]

{ #category : #running }
MolImplementationsTest >> testSelectingImplementation [

	clockImplementations implementationList selectItem: MolMyClockComponentImpl.

	self assert: [
		clockImplementations implementationList selectedItem
		= MolMyClockComponentImpl ]
]

{ #category : #running }
MolImplementationsTest >> testTitle [

	self assert: [
		clockImplementations title = 'MolMyClockComponent Implementations' ]
]
