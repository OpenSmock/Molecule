Class {
	#name : #MolWorldActionsMenuTest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Incubators-Tests'
}

{ #category : #tests }
MolWorldActionsMenuTest >> testWorldActionsMenu [
	| menuElements menuRegistration |
	menuElements := WorldState new menuBuilder itemList.
	
	"Find Molecule entry"
	menuRegistration := menuElements detect:[ :e | e name = #Molecule].
	self assert: menuRegistration notNil.
]

{ #category : #tests }
MolWorldActionsMenuTest >> testWorldActionsMenuBuilding [
	| menuBuilder |
	menuBuilder := WorldState new menuBuilder.
	
	MolWorldActionsMenu menuActionsOn: menuBuilder.
	MolWorldActionsMenu menuInspectOn: menuBuilder.
	MolWorldActionsMenu menuSearchOn: menuBuilder.
	MolWorldActionsMenu menuCreateOn: menuBuilder.
]
