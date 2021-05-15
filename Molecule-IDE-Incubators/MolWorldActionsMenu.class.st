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
		label: 'Actions on a component';
		help: 'Actions';
		icon: (self iconNamed: #glamorousExample);
		order: 1.2
]

{ #category : #'menu actions' }
MolWorldActionsMenu class >> menuCreateOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Create)
		parent: #MoleculeTools;
		label: 'Create a component';
		help: 'Create a component via system browser';
		icon: (self iconNamed: 'add').
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
