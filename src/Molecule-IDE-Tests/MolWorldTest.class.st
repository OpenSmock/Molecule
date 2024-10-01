Class {
	#name : #MolWorldTest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #tests }
MolWorldTest >> testOpenDefineComponentDialog [

	MolWorld openDefineComponentDialog
]

{ #category : #tests }
MolWorldTest >> testWorldMenu [
	| menuElements moleculeMenuEntry libraryMenu |
	
	menuElements := self currentWorld worldState menuBuilder menuSpec items.
	libraryMenu := menuElements detect:[ :e | e name = #Tools ].
	
	"Find Molecule entry"
	moleculeMenuEntry := libraryMenu subMenu items detect:[ :e | e name = #Molecule].
	self assert: moleculeMenuEntry notNil.
]

{ #category : #tests }
MolWorldTest >> testWorldMenuBuilding [
	| menuBuilder |
	menuBuilder := WorldState new menuBuilder.

	MolWorld menu00MoleculeOn: menuBuilder.
	
	MolWorld menu10SystemStatusOn: menuBuilder.
	MolWorld menu20DebugOn: menuBuilder.
	MolWorld menu21BrowseClassesOn: menuBuilder.
	MolWorld menu30ComponentManagerCleanUpOn: menuBuilder.
	MolWorld menu40ExamplesOn: menuBuilder.
	MolWorld menu50GithubOn: menuBuilder.
	MolWorld menu60ReportBugOn: menuBuilder.
	
	MolWorld toolsMenu110DeepCleanUp: menuBuilder.
	MolWorld toolsMenu10DefineComponentOn: menuBuilder.
	MolWorld toolsMenu90DefineDirtyComponentsOn: menuBuilder.
	MolWorld toolsMenu40InspectAllComponentInstances: menuBuilder.
	MolWorld toolsMenu80InspectDirtyComponentTypes: menuBuilder.
	MolWorld toolsMenu70InspectDirtyComponents: menuBuilder.
	MolWorld toolsMenu30ToggleDynamicContractUpdate: menuBuilder.
	MolWorld toolsMenu20ToggleLogsOn: menuBuilder.
]
