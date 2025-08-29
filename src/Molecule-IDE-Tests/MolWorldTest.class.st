Class {
	#name : #MolWorldTest,
	#superclass : #TestCase,
	#classInstVars : [
		'worldMenuItemCheck'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #accessing }
MolWorldTest class >> worldMenuItemCheck [

	^ worldMenuItemCheck
]

{ #category : #accessing }
MolWorldTest class >> worldMenuItemCheck: anObject [

	worldMenuItemCheck := anObject
]

{ #category : #'tests - menu' }
MolWorldTest class >> worldMenuItemTestMethod: anItem [
	"This method check if the pragma mecanism to setup a menu item is working"
	"Be aware to not inject behavior here because this is just a test method ant it is called when the menu is build!"

	<worldMenuItem: #Molecule>
	worldMenuItemCheck := true.
	
	anItem ifNil:[ Exception signal: 'Menu item should be not nil' ].
	anItem item = (MolWorld menuKey) ifFalse:[ Exception signal: 'Menu item should be equals to ', MolWorld menuKey printString ].
]

{ #category : #running }
MolWorldTest >> setUp [

	super setUp.

	self class worldMenuItemCheck: false.
	self deny: self class worldMenuItemCheck
]

{ #category : #running }
MolWorldTest >> testMenuKey [

	self assert: MolWorld menuKey equals: #Molecule
]

{ #category : #tests }
MolWorldTest >> testOpenDefineComponentDialog [

	| dialog |
	dialog := MolWorld openDefineComponentDialog.
	self assert: dialog notNil.
]

{ #category : #tests }
MolWorldTest >> testWorldMenuBuilding [

	| menuBuilder menuMethods |
	menuBuilder := PragmaMenuAndShortcutRegistration new.
	MolWorld menu00MoleculeOn: menuBuilder.
	
	menuMethods := MolWorld class pragmas select:[ :p | p selector = #worldMenu ] thenCollect:[ :p | p methodSelector ].
	self assert: menuMethods notEmpty.
	
	menuMethods do:[ :p |
		MolWorld perform: p with: menuBuilder.
	].

	self assert: self class worldMenuItemCheck.
]
