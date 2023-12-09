"
Commands for World menu
"
Class {
	#name : #MolWorld,
	#superclass : #Object,
	#category : #'Molecule-IDE-Menus'
}

{ #category : #scripts }
MolWorld class >> defineAComponent [

	<script>
	| component |
	component := self openDefineComponentDialog.
	component ifNotNil: [ :e | MolComponentFactory defineComponent: e ]
]

{ #category : #actions }
MolWorld class >> doComponentManagerCleanUpCatchingErrors [
	"Clean the current ComponentManager, ignore errors when appears and show a report if necessary"
	| error |
		
	[ MolComponentManager cleanUp ] on: Error do:[ :e | | result |
		error := e.
		result := UIManager default 
			confirm: 'Continue or debug error ?' 
			label: 'Molecule - Cleanup freezed by an error' 
			trueChoice: 'Continue' falseChoice: 'Debug' cancelChoice: 'Cancel' default: false.
		
		result = true ifTrue:[ error resume ]. 
		result = false ifTrue:[ error debug ]. 
	].
	
	error ifNil: [ 
		MolUtils showInformation: 'Cleanup done'.
	 ] ifNotNil: [ 
		MolUtils showInformation: 'Error during cleanup, try to re-clean to be safe.'.
	 ].
]

{ #category : #menu }
MolWorld class >> menu00MoleculeOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Molecule)
		parent: #Tools;
		label: 'Molecule';
		icon: MolIcon moleculeIcon;
		help: 'A component framework';
		order: 777;
		with:[
			(aBuilder group: #MoleculeStatus)
				order: 1;
				withSeparatorAfter.	
			(aBuilder group: #MoleculeTools)
				order: 2;
				withSeparatorAfter.	
			(aBuilder group: #MoleculeLinks)
				order: 3.
		]
]

{ #category : #menu }
MolWorld class >> menu10SystemStatusOn: aBuilder [
	<worldMenu>
	
	(aBuilder item: #InspectComponents)
		parent: #MoleculeStatus;
		order: 1.0;
		action: [
			MolComponentManager isRunningComponents ifTrue:[
				"Inspect home services"
				MolComponentManager default homeServices inspect 
			] ifFalse:[
				"No component are running"
				self inform: 'No components are running'
			]. 
		];
		icon: MolIcon moleculeComponentIcon;
		help: 'Component System Status, click to inspect running components. If no components are running there is an popup on the bottom left of the main Pharo windows.';
		label: 'Inspect running Components'
]

{ #category : #menu }
MolWorld class >> menu20DebugOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDebug)
		parent: #MoleculeTools;
		label: 'Debug and Tools';
		help: 'Debug and tools for Molecule environment';
		icon: (self iconNamed: #repair);
		order: 1.0
]

{ #category : #menu }
MolWorld class >> menu21BrowseClassesOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeBrowseClasses)
		parent: #MoleculeTools;
		label: 'Browse components classes';
		help: 'Browse all components classes (native and augmented) in a Tree view';
		icon: MolIcon moleculeIcon;
		order: 1.1;
		action: [ MolSpBrowseComponentClasses new open ]
]

{ #category : #menu }
MolWorld class >> menu30ComponentManagerCleanUpOn: aBuilder [
	<worldMenu>

	(aBuilder item: #MoleculeClearComponent)
		parent: #MoleculeTools;
		order: 2.0;
		help: 'Clean the current ComponentManager and current running Components';
		icon: (self iconNamed: #stop);
		action: [ | result |
			MolComponentManager isRunningComponents ifTrue: [ 
			"Confirmation window to execute the clean when system is running components"
				result := UIManager default confirm: 'Some Components are running, clean anyway ?' label: 'Molecule - Cleanup confirmation'.
			].

			((result notNil and: [ result ]) or: [ result isNil ]) ifTrue:[
			
				self doComponentManagerCleanUpCatchingErrors.
		
			].
			
		];
		label: 'Cleanup'
]

{ #category : #menu }
MolWorld class >> menu40ExamplesOn: aBuilder [
	<worldMenu>
	"Check if the examples package exists"
	| package |
	package := (Smalltalk packages detect: [ :p | p name = 'Molecule-Examples'] ifNone:[nil]).
	package ifNil:[ ^self ].
	
	(aBuilder item: #MoleculeExamples)
		parent: #MoleculeLinks;
		order: 1.0;
		label: 'Examples';
		help: 'Examples of Molecule applications';
		action: [ Smalltalk tools browser openOnPackage: package ];
		icon: (self iconNamed: #smallHome)
]

{ #category : #menu }
MolWorld class >> menu50GithubOn: aBuilder [
	<worldMenu>
	(aBuilder item: #GitHub)
		parent: #MoleculeLinks;
		order: 2.0;
		label: 'Visit GitHub';
		help: 'Go to Molecule GitHub';
		icon: (self iconNamed: 'github');
		action: [WebBrowser openOn: 'https://github.com/OpenSmock/Molecule']
]

{ #category : #menu }
MolWorld class >> menu60ReportBugOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ReportBug)
		parent: #MoleculeLinks;
		order: 3.0;
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
	searchClass := MCSearchFacade classSearchIn: list.
	searchClass title: 'Select the Molecule Component to define'.
	retValue := searchClass openModal.
	^ retValue answer
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu100DefineAllComponentsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDefineAllComponents)
		parent: #MoleculeDebug;
		order: 1.9;
		action: [ | result |
			"Confirmation window"
			result := UIManager default confirm: 'Do you want to define all the Molecule Components of your Pharo image ? 
This action may be necessary in the event of a Molecule update.' label: 'Molecule - Define all confirmation'.
			result ifTrue:[MolComponentFactory defineAllComponents]. 
		];
		icon: (self iconNamed: #warning);
		label: 'Define All Components'; 
		withSeparatorAfter 
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu10DefineComponentOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDefineComponent)
		parent: #MoleculeDebug;
		order: 1.0;
		action: [ self defineAComponent ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define a Component...'
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu110DeepCleanUp: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeClearComponent)
		parent: #MoleculeDebug;
		order: 11.0;
		icon: (self iconNamed: #stop);
		action: [| result |
			"Confirmation window"
			result := UIManager default confirm: 'Do you want to scan and clean all the Molecule Components of your Pharo image ? 
This action may be necessary if your system is broken.' 
				label: 'Molecule - Confirmation'.
			result ifTrue:[ MolComponentManager deepCleanUp]. 
		];
		label: 'Garbage, cleanup and release all components';
		help: 'Cleanup all Molecule system instances and components of the image'
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu20ToggleLogsOn: aBuilder [
	<worldMenu>
	MolUtils isLogActive 
		ifFalse: [ 
			(aBuilder item: #TurnOffMolLogs)
				parent: #MoleculeDebug;
				icon: (self iconNamed: #smallDebug);
				order: 2.0;
				action: [ MolUtils toggleLog. MenubarMorph reset. ];
				label: 'Active logs'
		]
		ifTrue: [ 
			(aBuilder item: #TurnOnMolLogs)
				parent: #MoleculeDebug;
				icon: (self iconNamed: #smallDebug);
				order: 2.0;
				action: [ MolUtils toggleLog. MenubarMorph reset.  ];
				label: 'Deactive logs'
		].
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu30ToggleDynamicContractUpdate: aBuilder [
	<worldMenu>
	MolComponentFactory default isDynamicContractUpdateActivated 
		ifFalse: [ 
			(aBuilder item: #TurnOffMolLogs)
				parent: #MoleculeDebug;
				icon: (self iconNamed: #smallAuthoringTools);
				order: 3.0;
				action: [ MolComponentFactory default activateDynamicContractUpdate. MenubarMorph reset. ];
				label: 'Active dynamic update'
		]
		ifTrue: [ 
			(aBuilder item: #TurnOnMolLogs)
				parent: #MoleculeDebug;
				icon: (self iconNamed: #smallAuthoringTools);
				order: 3.0;
				action: [ MolComponentFactory default deactivateDynamicContractUpdate.  MenubarMorph reset.  ];
				label: 'Deactive dynamic update'
		].
	
	aBuilder withSeparatorAfter
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu40InspectAllComponentInstances: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectAllComponentInstances)
		parent: #MoleculeDebug;
		order: 4.0;
		action: [ 
			| components |
			
			"Clean the memory before opening component list in case of non garbaged components"
			Smalltalk garbageCollect.

			components := OrderedCollection new.
			MolAbstractComponentImpl allSubInstancesDo:[ :component | components add: component ].
			MolComponentImpl users do: [:impl | impl allInstances do: [:component | components add: component ]].
			components inspect ];
		icon: (self iconNamed: #smallDebug);
		label: '[Advanced] Inspect all component instances';
		help:'Advanced function : Inspect all components including components not in the current running system. If you are not sure try to inspect current system running components.'
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu50InspectComponentManager: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectComponentManager)
		parent: #MoleculeDebug;
		order: 5.0;
		action: [ MolComponentManager default inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect the Component manager'
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu60InspectComponentFactory: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectComponentFactory)
		parent: #MoleculeDebug;
		order: 6.0;
		action: [ MolComponentFactory default inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect the Component factory'
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu70InspectDirtyComponents: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectDirtyComponents)
		parent: #MoleculeDebug;
		order: 7.0;
		action: [ MolComponentFactory default dirtyComponents inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect dirty Components'
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu80InspectDirtyComponentTypes: aBuilder [
	<worldMenu>
	(aBuilder item: #InspectDirtyComponentTypes)
		parent: #MoleculeDebug;
		order: 8.0;
		action: [ MolComponentFactory default dirtyComponentTypes inspect ];
		icon: (self iconNamed: #glamorousInspect);
		label: 'Inspect dirty Component Types';
		withSeparatorAfter
]

{ #category : #'menu - tools' }
MolWorld class >> toolsMenu90DefineDirtyComponentsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #MoleculeDefineDirtyComponents)
		parent: #MoleculeDebug;
		order: 10.0;
		action: [ MolComponentFactory defineDirtyComponents ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define dirty Components'
]
