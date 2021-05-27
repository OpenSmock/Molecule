"
class for actions on components in MolWorldMenu
"
Class {
	#name : #MolWorldActionsMenu,
	#superclass : #Object,
	#classInstVars : [
		'moleculeIcon'
	],
	#category : #'Molecule-IDE-Incubators-Menus'
}

{ #category : #accessing }
MolWorldActionsMenu class >> icon [
	^moleculeIcon ifNil: [ moleculeIcon := Form fromBinaryStream: self moleculeIcon base64Decoded readStream ]
]

{ #category : #menu }
MolWorldActionsMenu class >> menuActionsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeTools)
		parent: #Molecule;
		label: 'Actions on a component';
		help: 'Actions';
		"icon: (self iconNamed: #glamorousExample);"
		icon: MolIcon new icon;
		order: 1.2
]

{ #category : #'menu actions' }
MolWorldActionsMenu class >> menuCreateOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Create)
		parent: #MoleculeTools;
		label: 'Create a component';
		help: 'Create a component via system browser';
		icon: (self iconNamed: 'add');
		action: [ | spMolCreate |
					spMolCreate := SpMolCreateComponent new.
					spMolCreate openWithSpec ]
]

{ #category : #'menu actions' }
MolWorldActionsMenu class >> menuDeleteOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Delete)
		parent: #MoleculeTools;
		label: 'Delete a component';
		help: 'Delete a component via system browser';
		icon: (self iconNamed: 'delete').
]

{ #category : #'menu actions' }
MolWorldActionsMenu class >> menuEditOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Edit)
		parent: #MoleculeTools;
		label: 'Edit a component';
		help: 'Edit a component via system browser';
		icon: (self iconNamed: 'edit').
]

{ #category : #'as yet unclassified' }
MolWorldActionsMenu class >> menuInspectOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Inspect)
		parent: #MoleculeTools;
		label: 'Inspect a component';
		help: 'Inspect a component via system browser';
		icon: (self iconNamed: 'glamorousInspect');
		action: [ | spMolSearch |
					spMolSearch := SpMolInspect new.
					spMolSearch openWithSpec ]
]

{ #category : #'menu actions' }
MolWorldActionsMenu class >> menuReuseOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Reuse)
		parent: #MoleculeTools;
		label: 'Reuse a component';
		help: 'Reuse a component via system browser';
		icon: (self iconNamed: 'smallCopy').
]

{ #category : #'as yet unclassified' }
MolWorldActionsMenu class >> menuSearchOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Search)
		parent: #MoleculeTools;
		label: 'Search a component';
		help: 'Search a component via system browser';
		icon: (self iconNamed: 'glamorousSearch');
		action: [ | spMolSearch |
					spMolSearch := SpMolSearch new.
					spMolSearch openWithSpec ]
]

{ #category : #'as yet unclassified' }
MolWorldActionsMenu class >> moleculeIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAABcElEQVQ4jaWTTUsCURSG3zvOTEzawPSBRbQpRWiZtQwki7bSIiJXLqOFQe2CmB/gH4ggWlQSgQtbJxYEES1apgtXUbQxndJ0nHtvi8oEv6Z6lpfznHNfDgf4J6TV49LG7lSZy9cMgtROdBBGJaEyQ/ZCIT95NW4JpzCdavDZ70+nHt1UG/UB4B1GExQeMhAU8/3Uq7rgUVWolXJS12MDsuLiHWUA4ByS0scEwpkA/l3MCfDm5Yx2i15HMBQlnC0UkSsaMAfdKwFdvyGCaL/BWiJ5xTQtamraTiQeP7NtfkH2FuZOxpXeZQC4LxrZ9YtL33z0kDn7R1puqJFS/omJLlFadAiftUM98gSAY2qZXeV6BMOiiRqloIwhz3gGwKpDlLusoCECAMSCgTDhkDZT6YOArovii8e0HQEAts7TR3YnNkX4q9i2QQBgVrXE2pzJD4TAqpZoy6rI9v5YLl+7k2Sno51fM8t0dnJ4+pcfbuYD4niENW2FlpcAAAAASUVORK5CYII='
]
