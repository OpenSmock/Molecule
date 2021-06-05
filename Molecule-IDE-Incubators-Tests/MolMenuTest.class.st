Class {
	#name : #MolMenuTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Molecule-IDE-Incubators-Tests'
}

{ #category : #running }
MolMenuTest >> setUp [
	super setUp.
	menu := MolMenu new.
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
MolMenuTest >> testAddActionIcon [

	|test|
	test := menu add: 'test' action: (MessageSend receiver: [  menu browse ]  selector: #value) icon: #systemIcon.
	self assert: test equals: (menu items at: 1).
]

{ #category : #tests }
MolMenuTest >> testAddMenuItem [
	self assert: menu addMenuItem equals: (menu items at:1)
]

{ #category : #tests }
MolMenuTest >> testAddSeparator [
	self assert: menu addSeparator equals: nil.
	
	menu items.
	menu addMenuItem.
	self assert: menu addSeparator equals: menu.
]
