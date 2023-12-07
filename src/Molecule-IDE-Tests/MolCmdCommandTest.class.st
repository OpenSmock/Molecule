Class {
	#name : #MolCmdCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'menu',
		'toolcontext',
		'dataSource'
	],
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #utils }
MolCmdCommandTest >> createToolContextForClasses: aListOfClasses [

	| dataSources |
	toolcontext := ClyFullBrowserClassContext new.
	
	dataSources := Set new.
	aListOfClasses do:[ :c | | item |
		dataSource := ClyDataSourceItem new.
		item := ClyBrowserItem named: c name with: c.
		item addProperty: (ClyClassDefinitionProperty of: c).
		dataSource browserItem: item.	
		dataSources add: dataSource.
	].
		
	toolcontext selectedItems: dataSources.

]

{ #category : #running }
MolCmdCommandTest >> setUp [

	super setUp.
	menu := nil.
	toolcontext := nil.
	dataSource := nil.
]

{ #category : #running }
MolCmdCommandTest >> tearDown [

	menu := nil.
	toolcontext := nil.
	dataSource := nil.
	super tearDown.
]

{ #category : #tests }
MolCmdCommandTest >> testMolClassesCmdCommand [

	menu := MolDefineComponentCmdCommand new.

	self createToolContextForClasses: (Array new).
	menu prepareFullExecutionInContext: toolcontext.
	menu execute.
	self assert: menu executionResult equals: 0.
	self assert: menu selectedClasses size equals: 0.
	self assert: menu selectedComponentClasses size equals: 0.
	
	self createToolContextForClasses: (Array with: MolGNSSGPS with: MolGNSSGalileo).
	menu prepareFullExecutionInContext: toolcontext.
	menu execute.
	self assert: menu executionResult equals: 2.
	self assert: menu selectedClasses size equals: 2.
	self assert: menu selectedComponentClasses size equals: 2.
]

{ #category : #tests }
MolCmdCommandTest >> testMolCmdCommand [

	"test browser molecule requirements"
	SystemNavigation default allClasses do:[ :c |
		self assert: (c respondsTo: #isTrait).
		self assert: (c respondsTo: #isComponentClass).
		c isTrait ifTrue:[
			self assert: (c respondsTo: #isComponentType).
			self assert: (c respondsTo: #isComponentServices).	
			self assert: (c respondsTo: #isComponentEvents).	
			self assert: (c respondsTo: #isComponentParameters).	
		].
	].
]
