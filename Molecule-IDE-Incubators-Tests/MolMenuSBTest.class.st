Class {
	#name : #MolMenuSBTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Molecule-IDE-Incubators-Tests'
}

{ #category : #running }
MolMenuSBTest >> setUp [
	super setUp.
	menu := MolContextualMenu new.
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
MolMenuSBTest >> testExecute [
	
	| toolcontext dataSource item selectedItem |
	toolcontext := ClyFullBrowserClassContext new.
	dataSource := ClyDataSourceItem new.
	item := ClyBrowserItem named: MolGPSDataImpl name with: MolGPSDataImpl.
	item addProperty: (ClyClassDefinitionProperty of: MolGPSDataImpl).
	
	dataSource browserItem: item.
	
	selectedItem := toolcontext selectedItems asOrderedCollection.
	selectedItem add:dataSource.
	toolcontext selectedItems: selectedItem asArray.
	
	menu prepareFullExecutionInContext: toolcontext.
	
	self assert: menu execute equals: dataSource.
	
]
