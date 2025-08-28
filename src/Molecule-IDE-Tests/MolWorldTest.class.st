Class {
	#name : #MolWorldTest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Tests-Cases'
}

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
MolWorldTest >> testWorldMenu [
	| menuElements moleculeMenuEntry libraryMenu |
	
	menuElements := self currentWorld worldState menuBuilder menuSpec items.
	libraryMenu := menuElements detect:[ :e | e name = #Tools ].
	
	"Find Molecule entry"
	moleculeMenuEntry := libraryMenu subMenu items detect:[ :e | e name = #Molecule].
	self assert: moleculeMenuEntry notNil.
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

]
