Class {
	#name : #MolWorldMenuTest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Tests-Cases'
}

{ #category : #tests }
MolWorldMenuTest >> testWorldMenu [
	| menuElements menuRegistration |
	menuElements := WorldState new menuBuilder itemList.
	
	"Find Molecule entry"
	menuRegistration := menuElements detect:[ :e | e name = #Molecule].
	self assert: menuRegistration notNil.
]

{ #category : #tests }
MolWorldMenuTest >> testWorldMenuBuilding [
	| menuBuilder |
	menuBuilder := WorldState new menuBuilder.
	
	MolWorld currentComponentSystem: menuBuilder.
	MolWorld componentManagerCleanUp: menuBuilder.
	MolWorld deepCleanUp: menuBuilder.
	MolWorld defineComponentOn: menuBuilder.
	MolWorld defineDirtyComponentsOn: menuBuilder.
	MolWorld inspectAllComponentInstances: menuBuilder.
	MolWorld inspectComponents: menuBuilder.
	MolWorld inspectDirtyComponentTypes: menuBuilder.
	MolWorld inspectDirtyComponents: menuBuilder.
	MolWorld menuCommandOn: menuBuilder.
	MolWorld menuDebugOn: menuBuilder.
	MolWorld menuGithubOn: menuBuilder.
	MolWorld menuReportBugOn: menuBuilder.
	MolWorld toggleDynamicContractUpdate: menuBuilder.
	MolWorld toggleMolLogsOn: menuBuilder.
]
