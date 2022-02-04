Extension { #name : #MolWorld }

{ #category : #'*Molecule-IDE-Incubators' }
MolWorld class >> menu211InspectOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Inspect)
		parent: #MoleculeIncubator;
		label: 'Browse all Component classes';
		help:
			'Browse hierarchy Component classes (not from augmented class)';
		icon: (self iconNamed: 'glamorousInspect');
		action: [ 
			| spMolSearch |
			spMolSearch := SpMolInspect new.
			spMolSearch open ]
]

{ #category : #'*Molecule-IDE-Incubators' }
MolWorld class >> menu212SearchOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Search)
		parent: #MoleculeIncubator;
		label: 'Search';
		help: 'Open tools to search Components';
		icon: (self iconNamed: 'glamorousSearch');
		action: [ 
			| spMolSearch |
			spMolSearch := MolSearchPresenter new.
			spMolSearch open ]
]

{ #category : #'*Molecule-IDE-Incubators' }
MolWorld class >> menu213CreateOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Create)
		parent: #MoleculeIncubator;
		label: 'Component editor A';
		help: 'Open Component editor A to create new Components';
		icon: MolIcon moleculeIcon;
		action: [ 
			| spMolCreate |
			spMolCreate := SpMolCreateComponent new.
			spMolCreate open ]
]

{ #category : #'*Molecule-IDE-Incubators' }
MolWorld class >> menu214EditorBOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Editor)
		parent: #MoleculeIncubator;
		label: 'Component editor B';
		help: 'Open Component editor B to create new Components';
		icon: MolIcon moleculeIcon;
		action: [MolViewSpace openTest]
]

{ #category : #'*Molecule-IDE-Incubators' }
MolWorld class >> menu21IncubatorOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeIncubator)
		parent: #MoleculeTools;
		order: 3.0;
		label: 'Incubator tools';
		help: 'Find tools for component in development';
		icon: MolIcon moleculeIncubatorIcon 
]
