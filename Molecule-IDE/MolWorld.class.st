"
Commands for World menu
"
Class {
	#name : #MolWorld,
	#superclass : #Object,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #menu }
MolWorld class >> componentManagerCleanUp: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeClearComponent)
		parent: #Molecule;
		target: World;
		order: 1.3;
		help: 'Clean the current ComponentManager and current running Components';
		icon: (self iconNamed: #stop);
		action: [ | result |
			MolComponentManager isRunningComponents ifTrue:[
				"Confirmation window when system running components"
				result := UITheme current proceedIn: Morph new 
					text: 'Actually some Components are running, clean anyway ?' 
					title: 'Molecule - Confirmation'.
			].
			((result notNil and:[result]) or:[result isNil]) ifTrue:[
				MolComponentManager cleanUp.
				MolUtils showInformation: 'Clean Molecule'.
			]. 
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
		ifFalse:['No Components are running'].
	
	(aBuilder item: #InspectComponents)
		parent: #Molecule;
		target: World;
		enabled: isRunning;
		order: 1.0;
		action: [ MolComponentManager default homeServices inspect ];
		icon: (isRunning ifTrue:[(self iconNamed: #objects)] ifFalse:[(self iconNamed: #pause)]);
		help: 'Component System Status, click to inspect running components';
		label: label;
		withSeparatorAfter.
]

{ #category : #'menu - debug' }
MolWorld class >> deepCleanUp: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeClearComponent)
		parent: #MoleculeDebug;
		target: World;
		order: 1.9;
		icon: (self iconNamed: #remove);
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

{ #category : #'menu - debug' }
MolWorld class >> defineAllComponentsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDefineAllComponents)
		parent: #MoleculeDebug;
		target: World;
		order: 1.9;
		action: [ | result |
			"Confirmation window"
			result := UITheme current proceedIn: Morph new 
				text: 'Do you want to define all the Molecule Components of your Pharo image ? 
This action may be necessary in the event of a Molecule update.' 
				title: 'Molecule - Confirmation'.
			result ifTrue:[MolComponentFactory defineAllComponents]. 
		];
		icon: (self iconNamed: #warning);
		label: 'Define All Components'; 
		withSeparatorAfter 
]

{ #category : #'menu - debug' }
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

{ #category : #'menu - debug' }
MolWorld class >> defineDirtyComponentsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDefineDirtyComponents)
		parent: #MoleculeDebug;
		target: World;
		order: 1.8;
		action: [ MolComponentFactory defineDirtyComponents ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define dirty Components'
]

{ #category : #'menu - debug' }
MolWorld class >> inspectAllComponentInstances: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectAllComponentInstances)
		parent: #MoleculeDebug;
		target: World;
		order: 1.3;
		action: [ 
			| components |
			components := OrderedCollection new.
			MolAbstractComponentImpl allSubInstancesDo:[ :component | components add: component ].
			MolComponentImpl users do: [:impl | impl allInstances do: [:component | components add: component ]].
			components inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect all component instances'
]

{ #category : #'menu - debug' }
MolWorld class >> inspectComponentFactory: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectComponentFactory)
		parent: #MoleculeDebug;
		target: World;
		order: 1.5;
		action: [ MolComponentFactory default inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect the Component factory'
]

{ #category : #'menu - debug' }
MolWorld class >> inspectComponentManager: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectComponentManager)
		parent: #MoleculeDebug;
		target: World;
		order: 1.4;
		action: [ MolComponentManager default inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect the Component manager'
]

{ #category : #'menu - debug' }
MolWorld class >> inspectDirtyComponentTypes: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectDirtyComponentTypes)
		parent: #MoleculeDebug;
		target: World;
		order: 1.7;
		action: [ MolComponentFactory default dirtyComponentTypes inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect dirty Component Types';
		withSeparatorAfter
]

{ #category : #'menu - debug' }
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
MolWorld class >> menu00MoleculeOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Molecule)
		parent: #Tools;
		label: 'Molecule';
		icon: MolIcon moleculeIcon;
		help: 'A component framework';
		order: 777
]

{ #category : #menu }
MolWorld class >> menuDebugOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDebug)
		parent: #Molecule;
		label: 'Debug and Tools';
		help: 'Debug and tools for Molecule environment';
		icon: (self iconNamed: #repair);
		order: 1.2
]

{ #category : #menu }
MolWorld class >> menuExamplesOn: aBuilder [
	<worldMenu>
	"Check if the examples package exists"
	| package |
	package := (Smalltalk packages detect: [ :p | p name = 'Molecule-Examples'] ifNone:[nil]).
	package ifNil:[ ^self ].
	
	(aBuilder item: #MoleculeExamples)
		parent: #Molecule;
		label: 'Examples';
		help: 'Examples of Molecule applications';
		action: [ Smalltalk tools browser openOnPackage: package ];
		icon: (self iconNamed: #smallHome);
		order: 1.4
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

{ #category : #'menu - debug' }
MolWorld class >> toggleDynamicContractUpdate: aBuilder [
	<worldMenu>
	MolComponentFactory default isDynamicContractUpdateActivated 
		ifFalse: [ 
			(aBuilder item: #TurnOffMolLogs)
				parent: #MoleculeDebug;
				target: World;
				icon: (self iconNamed: #smallAuthoringTools);
				order: 1.2;
				action: [ MolComponentFactory default activateDynamicContractUpdate. MenubarMorph reset. ];
				label: 'Active dynamic update'
		]
		ifTrue: [ 
			(aBuilder item: #TurnOnMolLogs)
				parent: #MoleculeDebug;
				target: World;
				icon: (self iconNamed: #smallAuthoringTools);
				order: 1.2;
				action: [ MolComponentFactory default deactivateDynamicContractUpdate.  MenubarMorph reset.  ];
				label: 'Deactive dynamic update'
		].
	
	aBuilder withSeparatorAfter
]

{ #category : #'menu - debug' }
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
