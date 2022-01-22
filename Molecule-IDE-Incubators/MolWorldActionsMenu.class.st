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

{ #category : #menu }
MolWorldActionsMenu class >> menuActionsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeTools)
		parent: #Molecule;
		label: 'Incubator tools';
		help: 'Find tools for component in development';
		"icon: (self iconNamed: #glamorousExample);"
		icon: MolIcon new icon;
		order: 1.2
]

{ #category : #'menu actions' }
MolWorldActionsMenu class >> menuCreateOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Create)
		parent: #MoleculeTools;
		label: 'Component editor';
		help: 'Open Component editor to create new Components';
		icon: MolIcon new icon;
		action: [ | spMolCreate |
					spMolCreate := SpMolCreateComponent new.
					spMolCreate openWithSpec ]
]

{ #category : #'as yet unclassified' }
MolWorldActionsMenu class >> menuInspectOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Inspect)
		parent: #MoleculeTools;
		label: 'Browse all Component classes';
		help: 'Browse hierarchy Component classes (not from augmented class)';
		icon: (self iconNamed: 'glamorousInspect');
		action: [ | spMolSearch |
					spMolSearch := SpMolInspect new.
					spMolSearch openWithSpec ]
]

{ #category : #'as yet unclassified' }
MolWorldActionsMenu class >> menuSearchOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Search)
		parent: #MoleculeTools;
		label: 'Search';
		help: 'Open tools to search Components';
		icon: (self iconNamed: 'glamorousSearch');
		action: [ | spMolSearch |
					spMolSearch := SpMolSearch new.
					spMolSearch openWithSpec ]
]
