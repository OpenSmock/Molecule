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
		action: [ MolComponentManager cleanUp ];
		label: 'Clear Component manager'
]

{ #category : #scripts }
MolWorld class >> defineAComponent [
	<script>
	| component |
	component := self openDefineComponentDialog.
	component ifNotNil: [ MolComponentFactory defineComponent: component ].
]

{ #category : #menu }
MolWorld class >> defineComponentOn: aBuilder [
	<worldMenu>
	
	(aBuilder item: #MoleculeDefineComponent)
		parent: #Molecule;
		target: World;
		order: 1.2;
		action: [ self defineAComponent ];
		icon: (self iconNamed: #smallAdd);
		label: 'Define Component';
		withSeparatorAfter 
]

{ #category : #menu }
MolWorld class >> defineDirtyComponentsOn: aBuilder [
	<worldMenu>
	
	(aBuilder item: #MoleculeDefineDirtyComponents)
		parent: #Molecule;
		target: World;
		order: 1.1;
		action: [ MolComponentFactory defineDirtyComponents ];
		icon: (self iconNamed: #smallUpdate);
		label: 'Define dirty Components'
]

{ #category : #menu }
MolWorld class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Molecule)
		order: 6.1
]

{ #category : #scripts }
MolWorld class >> openDefineComponentDialog [
	<script>
	| searchClass list retValue |
	list := SystemNavigation default allClasses select: [ :c | 
		c isTrait not 
			and: [ (c allSuperclasses includes: Object) 
				and: [ c isComponent ]]].
	searchClass := SearchFacade classSearchIn: list.
	searchClass title: 'Define Component'.
	retValue := searchClass openModal.
	^ retValue answer.
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
				order: 1.0;
				action: [ MolUtils isLogActive: false. MenubarMorph reset. ];
				label: 'Turn OFF logs';
				withSeparatorAfter 
		]
		ifFalse: [ 
			(aBuilder item: #TurnOnMolLogs)
				parent: #Molecule;
				target: World;
				icon: (self iconNamed: #smallDebug);
				order: 1.0;
				action: [ MolUtils isLogActive: true. MenubarMorph reset.  ];
				label: 'Turn ON logs';
				withSeparatorAfter 
		].
]
