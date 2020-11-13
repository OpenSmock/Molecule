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
		order: 1.3;
		icon: (self iconNamed: #refresh);
		action: [ MolComponentManager cleanUp ];
		label: 'Do ComponentManager Cleanup'
]

{ #category : #menu }
MolWorld class >> deepCleanUp: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeClearComponent)
		parent: #MoleculeDebug;
		target: World;
		order: 1.7;
		icon: (self iconNamed: #refresh);
		action: [ MolComponentManager deepCleanUp ];
		label: 'Do Image Molecule Cleanup';
		help: 'Cleanup Molecule system and flush all components instance of the image'
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
		parent: #MoleculeDebug;
		target: World;
		order: 1.0;
		action: [ self defineAComponent ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define a Component...'
]

{ #category : #menu }
MolWorld class >> defineDirtyComponentsOn: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeDefineDirtyComponents)
		parent: #MoleculeDebug;
		target: World;
		order: 1.4;
		action: [ MolComponentFactory defineDirtyComponents ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define dirty Components'
]

{ #category : #menu }
MolWorld class >> inspectAllComponentInstances: aBuilder [

	<worldMenu>
	(aBuilder item: #InspectAllComponentInstances)
		parent: #MoleculeDebug;
		target: World;
		order: 1.6;
		action: [ 
			| components |
			components := OrderedCollection new.
			MolAbstractComponentImpl allSubInstancesDo:[ :component | components add: component ].
			MolComponentImpl users do: [:impl | impl allInstances do: [:component | components add: component ]].
			components inspect ];
		icon: (self iconNamed: #tools);
		label: 'Inspect all component instances'
]

{ #category : #menu }
MolWorld class >> inspectComponents: aBuilder [

	<worldMenu>
	(aBuilder item: #InspectComponents)
		parent: #Molecule;
		target: World;
		order: 1.3;
		action: [ MolComponentManager default homeServices inspect ];
		icon: (self iconNamed: #tools);
		label: 'Inspect instanciate Components'
]

{ #category : #menu }
MolWorld class >> inspectDirtyComponents: aBuilder [

	<worldMenu>
	(aBuilder item: #InspectDirtyComponents)
		parent: #MoleculeDebug;
		target: World;
		order: 1.3;
		action: [ MolComponentFactory default dirtyComponentTypes inspect ];
		icon: (self iconNamed: #tools);
		label: 'Inspect dirty component contracts'
]

{ #category : #menu }
MolWorld class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Molecule) order:  100
]

{ #category : #menu }
MolWorld class >> menuDebugOn: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeDebug)
		parent: #Molecule;
		label: 'Debug';
		help: 'Debug tools';
		icon: (self iconNamed: #smallDebug);
		order: 1.4;
		withSeparatorAfter 
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
MolWorld class >> toggleDynamicContractUpdate: aBuilder [

	<worldMenu>
	MolComponentFactory default isDynamicContractUpdateActivated 
		ifFalse: [ 
			(aBuilder item: #TurnOffMolLogs)
				parent: #MoleculeDebug;
				target: World;
				icon: (self iconNamed: #smallDebug);
				order: 1.2;
				action: [ MolComponentFactory default activateDynamicContractUpdate. MenubarMorph reset. ];
				label: 'Active dynamic update'
		]
		ifTrue: [ 
			(aBuilder item: #TurnOnMolLogs)
				parent: #MoleculeDebug;
				target: World;
				icon: (self iconNamed: #smallDebug);
				order: 1.2;
				action: [ MolComponentFactory default deactivateDynamicContractUpdate.  MenubarMorph reset.  ];
				label: 'Deactive dynamic update'
		].
]

{ #category : #menu }
MolWorld class >> toggleMolLogsOn: aBuilder [

	<worldMenu>
	MolUtils isLogActive 
		ifFalse: [ 
			(aBuilder item: #TurnOffMolLogs)
				parent: #MoleculeDebug;
				target: World;
				icon: (self iconNamed: #smallDebug);
				order: 1.1;
				action: [ MolUtils toggleLog. MenubarMorph reset. ];
				label: 'Active logs'
		]
		ifTrue: [ 
			(aBuilder item: #TurnOnMolLogs)
				parent: #MoleculeDebug;
				target: World;
				icon: (self iconNamed: #smallDebug);
				order: 1.1;
				action: [ MolUtils toggleLog. MenubarMorph reset.  ];
				label: 'Deactive logs'
		].
]
