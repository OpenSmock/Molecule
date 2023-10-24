Class {
	#name : #MolMenuSBTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Molecule-IDE-Incubator-Tests-Cases'
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
	item := ClyBrowserItem named: MolGNSSGPS name with: MolGNSSGPS.
	item addProperty: (ClyClassDefinitionProperty of: MolGNSSGPS).
	
	dataSource browserItem: item.
	
	selectedItem := toolcontext selectedItems asOrderedCollection.
	selectedItem add:dataSource.
	toolcontext selectedItems: selectedItem asArray.
	
	menu prepareFullExecutionInContext: toolcontext.
	
	self assert: menu execute equals: dataSource.
	
]
