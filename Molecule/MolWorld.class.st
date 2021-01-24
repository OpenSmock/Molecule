"
Commands for World menu
"
Class {
	#name : #MolWorld,
	#superclass : #Object,
	#category : #'Molecule-Tools'
}

{ #category : #menu }
MolWorld class >> componentManagerCleanUp: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeClearComponent)
		parent: #Molecule;
		target: World;
		order: 1.3;
		help: 'Clean the current ComponentManager and current running Components';
		icon: (self iconNamed: #refresh);
		action: [ | result |
			MolComponentManager isRunningComponents ifTrue:[
				"Confirmation window when system running components"
				result := UITheme current proceedIn: Morph new 
					text: 'Actually some Components are running, clean anyway ?' 
					title: 'Molecule - Confirmation'.
			].
			((result notNil and:[result]) or:[result isNil]) ifTrue:[MolComponentManager cleanUp]. 
		];
		label: 'Do ComponentManager Cleanup';
		withSeparatorAfter 
]

{ #category : #menu }
MolWorld class >> currentComponentSystem: aBuilder [
	<worldMenu>
	| label isRunning |
	isRunning := MolComponentManager isRunningComponents.
	label := isRunning 
		ifTrue:['System is running Components'] 
		ifFalse:['Actually, no Components are running'].
	
	(aBuilder item: #InspectComponents)
		parent: #Molecule;
		target: World;
		enabled: false;
		order: 1.0;
		icon: (isRunning ifTrue:[(self iconNamed: #smallInfo)] ifFalse:[(self iconNamed: #pause)]);
		help: 'Component System Status';
		label: label.
]

{ #category : #menu }
MolWorld class >> deepCleanUp: aBuilder [

	<worldMenu>
	(aBuilder item: #MoleculeClearComponent)
		parent: #MoleculeDebug;
		target: World;
		order: 1.8;
		icon: (self iconNamed: #refresh);
		action: [| result |
			"Confirmation window"
			result := UITheme current proceedIn: Morph new 
				text: 'Do you want to scan and clean all the Molecule Components of your Pharo image ? 
This action may be necessary if your system is broken.' 
				title: 'Molecule - Confirmation'.
			result ifTrue:[ MolComponentManager deepCleanUp]. 
		];
		label: 'Do Image Molecule Cleanup';
		help: 'Cleanup all Molecule system instances and components of the image'
]

{ #category : #scripts }
MolWorld class >> defineAComponent [

	<script>
	| component |
	component := self openDefineComponentDialog.
	component ifNotNil: [ :e | MolComponentFactory defineComponent: e ]
]

{ #category : #menu }
MolWorld class >> defineAllComponentsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDefineAllComponents)
		parent: #MoleculeDebug;
		target: World;
		order: 1.7;
		action: [ | result |
			"Confirmation window"
			result := UITheme current proceedIn: Morph new 
				text: 'Do you want to define all the Molecule Components of your Pharo image ? 
This action may be necessary in the event of a Molecule update.' 
				title: 'Molecule - Confirmation'.
			result ifTrue:[MolComponentFactory defineAllComponents]. 
		];
		icon: (self iconNamed: #warning);
		label: 'Define All Components'
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
		order: 1.6;
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
		order: 1.5;
		action: [ 
			| components |
			components := OrderedCollection new.
			MolAbstractComponentImpl allSubInstancesDo:[ :component | components add: component ].
			MolComponentImpl users do: [:impl | impl allInstances do: [:component | components add: component ]].
			components inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect all component instances'
]

{ #category : #menu }
MolWorld class >> inspectComponents: aBuilder [

	<worldMenu>
	(aBuilder item: #InspectComponents)
		parent: #Molecule;
		target: World;
		order: 1.1;
		action: [ MolComponentManager default homeServices inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect running Components';
		withSeparatorAfter
]

{ #category : #menu }
MolWorld class >> inspectDirtyComponentTypes: aBuilder [

	<worldMenu>
	(aBuilder item: #InspectDirtyComponentTypes)
		parent: #MoleculeDebug;
		target: World;
		order: 1.3;
		action: [ MolComponentFactory default dirtyComponentTypes inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect dirty Component Types'
]

{ #category : #menu }
MolWorld class >> inspectDirtyComponents: aBuilder [

	<worldMenu>
	(aBuilder item: #InspectDirtyComponents)
		parent: #MoleculeDebug;
		target: World;
		order: 1.4;
		action: [ MolComponentFactory default dirtyComponents inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect dirty Components'
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
		label: 'Debug and Tools';
		help: 'Debug and tools for Molecule environment';
		icon: (self iconNamed: #smallDebug);
		order: 1.2
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
			        (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
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
	
	aBuilder withSeparatorAfter
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
