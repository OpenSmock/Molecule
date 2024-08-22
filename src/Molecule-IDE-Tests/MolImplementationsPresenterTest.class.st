Class {
	#name : #MolImplementationsPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'clockImplementations',
		'geoPosImplementations'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolImplementationsPresenterTest >> setUp [

	super setUp.
	MolComponentManager cleanUp.

	"Put here a common initialization logic for tests"
	clockImplementations := MolImplementationsPresenter new.
	clockImplementations type: MolMyClockComponent.

	geoPosImplementations := MolImplementationsPresenter new.
	geoPosImplementations type: MolGeoPosEquipmentType.
]

{ #category : #running }
MolImplementationsPresenterTest >> tearDown [ 

	MolComponentManager cleanUp.
	super tearDown
]

{ #category : #running }
MolImplementationsPresenterTest >> testBrowseButtonActivated [

	| enabled |
	clockImplementations implementationList selectItem:
		MolMyClockComponentImpl.
	enabled := clockImplementations buttonBrowse isEnabled.

	self assert: [ enabled ]
]

{ #category : #running }
MolImplementationsPresenterTest >> testFilter [

	| implementations |
	geoPosImplementations implementationList filterListItems: 'gps'.
	implementations := geoPosImplementations implementationList items.

	self assert: [ implementations size = 2 ]
]

{ #category : #running }
MolImplementationsPresenterTest >> testSelectingImplementation [

	clockImplementations implementationList selectItem: MolMyClockComponentImpl.

	self assert: [
		clockImplementations implementationList selectedItem
		= MolMyClockComponentImpl ]
]

{ #category : #running }
MolImplementationsPresenterTest >> testTitle [

	self assert: [
		clockImplementations title = 'MolMyClockComponent Implementations' ]
]
