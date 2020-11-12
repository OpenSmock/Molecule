"
Commands for World menu
"
Class {
	#name : #MolWorld,
	#superclass : #Object,
	#category : #'Molecule-Tools'
}

{ #category : #menu }
MolWorld class >> clearComponentManagerOn: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeClearComponent)
		parent: #Molecule;
		target: World;
		order: 2.0;
		icon: (self iconNamed: #refresh);
		action: [ MolComponentManager cleanUp ];
		label: 'Do Cleanup'
]

{ #category : #scripts }
MolWorld class >> defineAComponent [

	<script>
	| component |
	component := self openDefineComponentDialog.
	component ifNotNil: [ :e | MolComponentFactory defineComponent: e ]
]

{ #category : #menu }
MolWorld class >> defineComponentOn: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeDefineComponent)
		parent: #Molecule;
		target: World;
		order: 1.3;
		action: [ self defineAComponent ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define a Component...';
		withSeparatorAfter
]

{ #category : #menu }
MolWorld class >> defineDirtyComponentsOn: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeDefineDirtyComponents)
		parent: #Molecule;
		target: World;
		order: 1.2;
		action: [ MolComponentFactory defineDirtyComponents ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define dirty Components'
]

{ #category : #menu }
MolWorld class >> inspectComponents: aBuilder [

	<worldMenu>
	(aBuilder item: #InspectComponents)
		parent: #Molecule;
		target: World;
		order: 1.1;
		action: [ MolComponentManager default homeServices inspect ];
		icon: (self iconNamed: #tools);
		label: 'Inspect all Components';
		withSeparatorAfter
]

{ #category : #menu }
MolWorld class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Molecule) order: 6.1
]

{ #category : #menu }
MolWorld class >> menuGithubOn: aBuilder [

	<worldMenu>
	(aBuilder item: #GitHub)
		parent: #Molecule;
		order: 3.0;
		label: 'Visit GitHub';
		help: 'Go to Molecule GitHub';
		icon: (self iconNamed: 'github');
		action: [WebBrowser openOn: 'https://github.com/OpenSmock/Molecule']
]

{ #category : #menu }
MolWorld class >> menuReportBugOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReportBug)
		parent: #Molecule;
		order: 3.1;
		label: 'Report a bug';
		help: 'Go to the Molecule GitHub to report an issue';
		icon: (self iconNamed: 'github');
		action: [WebBrowser openOn: 'https://github.com/OpenSmock/Molecule/issues/new']
]

{ #category : #scripts }
MolWorld class >> openDefineComponentDialog [

	<script>
	| searchClass list retValue |
	list := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ 
			        (c allSuperclasses includes: Object) and: [ c isComponent ] ] ].
	searchClass := SearchFacade classSearchIn: list.
	searchClass title: 'Select the Molecule Component to define'.
	retValue := searchClass openModal.
	^ retValue answer
]

{ #category : #menu }
MolWorld class >> toggleMolLogsOn: aBuilder [
	<worldMenu>
	
	MolUtils isLogActive 
		ifTrue: [ 
			(aBuilder item: #TurnOffMolLogs)
				parent: #Molecule;
				target: World;
				icon: (self iconNamed: #smallDebug);
				order: 2.1;
				action: [ MolUtils isLogActive: false. MenubarMorph reset. ];
				label: 'Hide logs';
				withSeparatorAfter 
		]
		ifFalse: [ 
			(aBuilder item: #TurnOnMolLogs)
				parent: #Molecule;
				target: World;
				icon: (self iconNamed: #smallDebug);
				order: 2.1;
				action: [ MolUtils isLogActive: true. MenubarMorph reset.  ];
				label: 'Show logs';
				withSeparatorAfter 
		].
]
