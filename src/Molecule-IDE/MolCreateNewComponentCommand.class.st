Class {
	#name : #MolCreateNewComponentCommand,
	#superclass : #MolClassesCmdCommand,
	#instVars : [
		'package',
		'packageTag',
		'browser'
	],
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolCreateNewComponentCommand class >> browserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: MolCmdMenuGroup
		  order: 80
		  for: ClyFullBrowserClassContext
]

{ #category : #testing }
MolCreateNewComponentCommand class >> canBeExecutedInContext: aBrowserContext [
	
	^self isAbstract not and:[aBrowserContext isPackageSelected]

]

{ #category : #accessing }
MolCreateNewComponentCommand >> defaultMenuIconName [
	^#class
]

{ #category : #accessing }
MolCreateNewComponentCommand >> defaultMenuItemName [

	^ 'New component'
]

{ #category : #accessing }
MolCreateNewComponentCommand >> description [

	^ 'Initialize an empty component implementation with traits for class, events and services'
]

{ #category : #execution }
MolCreateNewComponentCommand >> execute [

	| componentDefinition classGeneratedComp traitType compImplName eventName serviceName traitServices traitEvents |
	componentDefinition := self morphicUIManager request: 'Define component name:' initialAnswer: 'MyComponent'.
	componentDefinition isEmptyOrNil ifTrue: [ ^ self ].
	
	MolComponentFactory createComponentType: componentDefinition asSymbol in: package tag: packageTag.
	
	traitType := self class environment at: componentDefinition asSymbol.
	
	eventName := (componentDefinition, 'Events') asSymbol.
	MolComponentFactory createComponentEvents: eventName in: package tag: packageTag.
	traitEvents := self class environment at: eventName.

	serviceName := (componentDefinition, 'Services') asSymbol.
	MolComponentFactory createComponentServices: serviceName in: package tag: packageTag.
	traitServices := self class environment at: serviceName.

	compImplName := (componentDefinition, 'Impl') asSymbol.
	MolComponentFactory createComponentNamed: compImplName in: package name tag: packageTag.
	
	classGeneratedComp := self class environment at: compImplName.
	classGeneratedComp setTraitComposition: traitType.
	
	MolComponentFactory addProvidedServices: traitServices in: traitType.
	MolComponentFactory addProducedEvents: traitEvents in: traitType
]

{ #category : #execution }
MolCreateNewComponentCommand >> prepareFullExecutionInContext: aBrowserContext [

	super prepareFullExecutionInContext: aBrowserContext.

	package := aBrowserContext lastSelectedPackage.
	aBrowserContext isPackageTagSelected ifFalse:[^self].
	packageTag := aBrowserContext lastSelectedPackageTag

]

{ #category : #execution }
MolCreateNewComponentCommand >> readParametersFromContext: aToolContext [
	super readParametersFromContext: aToolContext.
	browser := aToolContext browser
]
