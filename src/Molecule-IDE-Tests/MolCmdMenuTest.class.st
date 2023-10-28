Class {
	#name : #MolCmdMenuTest,
	#superclass : #TestCase,
	#instVars : [
		'menu'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #running }
MolCmdMenuTest >> setUp [

	super setUp.
	menu := MolClassesCmdCommand new
]

{ #category : #tests }
MolCmdMenuTest >> testExecute [
	| toolcontext dataSource item selectedItem |

	toolcontext := ClyFullBrowserClassContext new.
	dataSource := ClyDataSourceItem new.
	item := ClyBrowserItem named: MolCompleteComponentImpl name with: MolCompleteComponentImpl.
	item addProperty: (ClyClassDefinitionProperty of: MolCompleteComponentImpl).
	
	dataSource browserItem: item.
	
	selectedItem := toolcontext selectedItems asOrderedCollection.
	selectedItem add:dataSource.
	toolcontext selectedItems: selectedItem asArray.
	menu prepareFullExecutionInContext: toolcontext.
	
	self assert: menu execute equals: dataSource.
	
]
